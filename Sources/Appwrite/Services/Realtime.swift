//
//  Created by Jake Barnby on 13/09/21.
//

import Foundation
import Swockets
import AsyncHTTPClient
import NIO
import NIOHTTP1

open class Realtime : Service {

    private let TYPE_ERROR = "error"
    private let TYPE_EVENT = "event"
    private let DEBOUNCE_MILLIS = 1

    private var socketClient: SwocketClient? = nil
    private var channelCallbacks = [String: NSMutableSet]()
    private var errorCallbacks = [(AppwriteError) -> Void]()

    let connectSync = DispatchQueue(label: "ConnectSync")
    let callbackSync = DispatchQueue(label: "CallbackSync")

    private var subCallDepth = 0

    private func createSocket() {
        var queryParams = "project=\(client.config["project"]!)"

        for channel in channelCallbacks.keys {
            queryParams += "&channels[]=\(channel)"
        }

        let url = "\(client.endPointRealtime!)/realtime?\(queryParams)"

        if (socketClient != nil) {
            closeSocket()
        }

        socketClient = SwocketClient(url, delegate: self)!

        try! socketClient?.connect()
    }

    private func closeSocket() {
        socketClient?.close()
        //socket?.close(RealtimeCode.POLICY_VIOLATION.value, null)
    }

    public func subscribe(
        channels: [String],
        callback: @escaping (RealtimeResponseEvent<Model>) -> Void
    ) -> RealtimeSubscription {
        return subscribe(
            channels: channels,
            payloadType: Model.self,
            callback: callback
        )
    }

    public func subscribe<T : AnyObject>(
        channels: [String],
        payloadType: T.Type,
        callback: @escaping (RealtimeResponseEvent<T>) -> Void
    ) -> RealtimeSubscription {
        for channel in channels {
            if channelCallbacks[channel] == nil {
                channelCallbacks[channel] = NSMutableSet()
                channelCallbacks[channel]?.add(RealtimeCallback(
                    with: payloadType,
                    and: callback as (RealtimeResponseEvent<T>) -> Void
                ))
                continue
            }
            channelCallbacks[channel]?.add(RealtimeCallback(
                with: payloadType,
                and: callback as (RealtimeResponseEvent<T>) -> Void
            ))
        }

        connectSync.sync {
            subCallDepth+=1
        }

        let group = DispatchGroup()

        group.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(DEBOUNCE_MILLIS)) {
            if (self.subCallDepth == 1) {
                self.createSocket()
            }
            self.connectSync.sync {
                self.subCallDepth-=1
            }
            group.leave()
        }
        group.wait()

        return RealtimeSubscription {
            self.unsubscribe(channels: channels)
        }
    }

    func unsubscribe(channels: [String]) {
        for channel in channels {
            channelCallbacks[channel] = NSMutableSet()
        }
        if (channelCallbacks.allSatisfy { $0.value.count != 0 }) {
            errorCallbacks = []
            closeSocket()
        }
    }

    func doOnError(callback: @escaping (AppwriteError) -> Void) {
        errorCallbacks.append(callback)
    }
}

extension Realtime: SwocketClientDelegate {

    public func onMessage(text: String) {
        let message = try! text.fromJson(to: RealtimeResponse.self)
        switch message.type {
        case TYPE_ERROR: handleResponseError(from: message)
        case TYPE_EVENT: handleResponseEvent(from: message)
        default: break
        }
    }

    public func onMessage(data: Data) {
    }

    public func onClose(channel: Channel, data: Data) {
//        if (code == RealtimeCode.POLICY_VIOLATION.value) {
//            return
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            self.createSocket()
        }
    }

    public func onError(error: Error?, status: HTTPResponseStatus?) {
        print(error!)
    }

    func handleResponseError(from message: RealtimeResponse) {
        let error = try! message.data
            .toJson()
            .fromJson(to: AppwriteError.self)

        for callback in errorCallbacks {
            callback(error)
        }
    }

    func handleResponseEvent(from message: RealtimeResponse) {
        let event = try! message.data
            .toJson()
            .fromJson(to: RealtimeResponseEvent<Model>.self)

        for channel in event.channels {
            for callback in channelCallbacks[channel]! {
                let typedCallback = (callback as! RealtimeCallback<Model>)

                event.payload = try! event.payload
                    .toJson()
                    .fromJson(to: typedCallback.payloadType)

                typedCallback.callback(event)
            }
        }
    }
}
