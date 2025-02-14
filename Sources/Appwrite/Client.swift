//
// Client.swift
//
// Created by Armino <devel@boioiong.com>
// GitHub: https://github.com/armino-dev/sdk-generator
//

import NIO
import NIOSSL
import Foundation
import AsyncHTTPClient

let DASHDASH = "--"
let CRLF = "\r\n"

open class Client {

    // MARK: Properties

    open var endPoint = "https://appwrite.io/v1"

    open var endPointRealtime: String? = nil

    open var headers: [String: String] = [
      "content-type": "",
      "x-sdk-version": "appwrite:swiftclient:0.0.1",
      "X-Appwrite-Response-Format": "0.7.0"    
    ]

    open var config: [String: String] = [:]

    open var http: HTTPClient

    private static let boundaryChars =
        "abcdefghijklmnopqrstuvwxyz1234567890"

    private static var eventLoopGroupProvider =
        HTTPClient.EventLoopGroupProvider.createNew

    // MARK: Methods

    public init() {
        http = Client.createHTTP()
    }

    private static func createHTTP(
        selfSigned: Bool = false,
        maxRedirects: Int = 5,
        alloweRedirectCycles: Bool = false,
        connectTimeout: TimeAmount = .seconds(30),
        readTimeout: TimeAmount = .seconds(30)
    ) -> HTTPClient {
        let timeout = HTTPClient.Configuration.Timeout(
            connect: connectTimeout,
            read: readTimeout
        )
        let redirect = HTTPClient.Configuration.RedirectConfiguration.follow(
            max: 5,
            allowCycles: false
        )
        var tls = TLSConfiguration
            .makeClientConfiguration()

        if selfSigned {
            tls.certificateVerification = .none
        }

        return HTTPClient(
            eventLoopGroupProvider: eventLoopGroupProvider,
            configuration: HTTPClient.Configuration(
                tlsConfiguration: tls,
                redirectConfiguration: redirect,
                timeout: timeout,
                decompression: .enabled(limit: .none)
            )
        )

    }

    deinit {
        do {
            try http.syncShutdown()
        } catch {
            print(error)
        }
    }

    ///
    /// Set Project
    ///
    /// Your project ID
    ///
    /// @param String value
    ///
    /// @return Client
    ///
    open func setProject(_ value: String) -> Client {
        config["project"] = value
        _ = addHeader(key: "X-Appwrite-Project", value: value)
        return self
    }

    ///
    /// Set Key
    ///
    /// Your secret API key
    ///
    /// @param String value
    ///
    /// @return Client
    ///
    open func setKey(_ value: String) -> Client {
        config["key"] = value
        _ = addHeader(key: "X-Appwrite-Key", value: value)
        return self
    }

    ///
    /// Set JWT
    ///
    /// Your secret JSON Web Token
    ///
    /// @param String value
    ///
    /// @return Client
    ///
    open func setJWT(_ value: String) -> Client {
        config["jwt"] = value
        _ = addHeader(key: "X-Appwrite-JWT", value: value)
        return self
    }

    ///
    /// Set Locale
    ///
    /// @param String value
    ///
    /// @return Client
    ///
    open func setLocale(_ value: String) -> Client {
        config["locale"] = value
        _ = addHeader(key: "X-Appwrite-Locale", value: value)
        return self
    }

    ///
    /// Set Mode
    ///
    /// @param String value
    ///
    /// @return Client
    ///
    open func setMode(_ value: String) -> Client {
        config["mode"] = value
        _ = addHeader(key: "X-Appwrite-Mode", value: value)
        return self
    }


    ///
    /// Set self signed
    ///
    /// @param Bool status
    ///
    /// @return Client
    ///
    open func setSelfSigned(_ status: Bool = false) -> Client {
        try! http.syncShutdown()
        http = Client.createHTTP(selfSigned: status)
        return self
    }

    ///
    /// Set endpoint
    ///
    /// @param String endPoint
    ///
    /// @return Client
    ///
    open func setEndpoint(_ endPoint: String) -> Client {
        self.endPoint = endPoint

        if (self.endPointRealtime == nil && endPoint.starts(with: "http")) {
            self.endPointRealtime = endPoint
                .replacingOccurrences(of: "http://", with: "ws://")
                .replacingOccurrences(of: "https://", with: "wss://")
        }

        return self
    }

    ///
    /// Set realtime endpoint.
    ///
    /// @param String endPoint
    ///
    /// @return Client
    ///
    open func setEndpointRealtime(_ endPoint: String) -> Client {
        self.endPointRealtime = endPoint

        return self
    }

    ///
    /// Add header
    ///
    /// @param String key
    /// @param String value
    ///
    /// @return Client
    ///
    open func addHeader(key: String, value: String) -> Client {
        self.headers[key] = value
        return self
    }

   ///
   /// Builds a query string from parameters
   ///
   /// @param Dictionary<String, Any?> params
   /// @param String prefix
   ///
   /// @return String
   ///
   open func parametersToQueryString(params: [String: Any?]) -> String {
       var output: String = ""

       func appendWhenNotLast(_ index: Int, ofTotal count: Int, outerIndex: Int? = nil, outerCount: Int? = nil) {
           if (index != count - 1 || (outerIndex != nil
               && outerCount != nil
               && index == count - 1
               && outerIndex! != outerCount! - 1)) {
               output += "&"
           }
       }

       for (parameterIndex, element) in params.enumerated() {
           switch element.value {
           case nil:
               break
           case is Array<Any?>:
               let list = element.value as! Array<Any?>
               for (nestedIndex, item) in list.enumerated() {
                   output += "\(element.key)[]=\(item!)"
                   appendWhenNotLast(nestedIndex, ofTotal: list.count, outerIndex: parameterIndex, outerCount: params.count)
               }
               appendWhenNotLast(parameterIndex, ofTotal: params.count)
           default:
               output += "\(element.key)=\(element.value!)"
               appendWhenNotLast(parameterIndex, ofTotal: params.count)
           }
       }

       return output.addingPercentEncoding(
           withAllowedCharacters: .urlHostAllowed
       ) ?? ""
   }

    ///
    /// Make an API call
    ///
    /// @param String method
    /// @param String path
    /// @param Dictionary<String, Any?> params
    /// @param Dictionary<String, String> headers
    /// @return Response
    /// @throws Exception
    ///
    func call(method: String, path: String = "", headers: [String: String] = [:], params: [String: Any?] = [:], sink: ((ByteBuffer) -> Void)? = nil,  completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        self.headers.merge(headers) { (_, new) in
            new
        }

        let queryParameters = method == "GET" && !params.isEmpty
            ? "?" + parametersToQueryString(params: params)
            : ""

        let targetURL = URL(string: endPoint + path + queryParameters)!

        var request: HTTPClient.Request
        do {
            request = try HTTPClient.Request(
                url: targetURL,
                method: .RAW(value: method)
            )
        } catch {
            completion?(Result.failure(AppwriteError(message: error.localizedDescription)))
            return
        }

        addHeaders(to: &request)
        addCookies(to: &request)


        if "GET" == method {
            execute(request, completion: completion)
            return
        }

        do {
            try buildBody(for: &request, with: params)
        } catch let error {
            completion?(Result.failure(AppwriteError(message: error.localizedDescription)))
            return
        }

        execute(request, withSink: sink, completion: completion)
    }

    fileprivate func addHeaders(to request: inout HTTPClient.Request) {
        for (key, value) in self.headers {
            request.headers.add(name: key, value: value)
        }
    }

    fileprivate func addCookies(to request: inout HTTPClient.Request) {
        let cookieJson = UserDefaults.standard.string(forKey: "\(request.url.host ?? "")-cookies")
        let cookies = try! cookieJson?.fromJson(to: [HTTPClient.Cookie].self)

        if let authCookie = cookies?.first(where: { cookie in
            cookie.name.starts(with: "a_session_") && !cookie.name.contains("legacy")
        }) {
            request.headers.add(name: "cookie", value: "\(authCookie.name)=\(authCookie.value)")
        }
    }

    fileprivate func buildBody(
        for request: inout HTTPClient.Request,
        with params: [String: Any?]
    ) throws {
        if request.headers["content-type"][0] == "multipart/form-data" {
            buildMultipart(&request, with: params)
        } else {
            try buildJSON(&request, with: params)
        }
    }

    fileprivate func execute(
        _ request: HTTPClient.Request,
        withSink bufferSink: ((ByteBuffer) -> Void)? = nil,
        completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil
    ) {
        if bufferSink == nil {
            http.execute(
                request: request,
                delegate: ResponseAccumulator(request: request)
            ).futureResult.whenComplete( { result in
                complete(with: result)
            })
            return
        }

        http.execute(
            request: request,
            delegate: StreamingDelegate(request: request, sink: bufferSink)
        ).futureResult.whenComplete { result in
            complete(with: result)
        }

        func complete(with result: Result<HTTPClient.Response, Error>) {
            if let completion = completion {
                switch result {
                case .failure(let error): print(error)
                case .success(let response):
                    guard response.cookies.count > 0 else {
                        break
                    }
                    let cookieJson = try! response.cookies.toJson()
                    UserDefaults.standard.set(cookieJson, forKey: "\(response.host)-cookies")
                }
                completion(result.mapError { AppwriteError(message: $0.localizedDescription) })
            }
        }
    }

    fileprivate func randomBoundary() -> String {
        var string = ""
        for _ in 0..<16 {
            string.append(Client.boundaryChars.randomElement()!)
        }
        return string
    }

    fileprivate func buildJSON(
        _ request: inout HTTPClient.Request,
        with params: [String: Any?] = [:]
    ) throws {
        let json = try JSONSerialization.data(withJSONObject: params, options: [])

        request.body = .data(json)
    }

    fileprivate func buildMultipart(
        _ request: inout HTTPClient.Request,
        with params: [String: Any?] = [:]
    ) {
        func addPart(name: String, value: Any) {
            bodyBuffer.writeString(DASHDASH)
            bodyBuffer.writeString(boundary)
            bodyBuffer.writeString(CRLF)
            bodyBuffer.writeString("Content-Disposition: form-data; name=\"\(name)\"")

            if let file = value as? File {
                bodyBuffer.writeString("; filename=\"\(file.name)\"")
                bodyBuffer.writeString(CRLF)
                bodyBuffer.writeString("Content-Length: \(bodyBuffer.readableBytes)")
                bodyBuffer.writeString(CRLF+CRLF)
                bodyBuffer.writeBuffer(&file.buffer)
                bodyBuffer.writeString(CRLF)
                return
            }

            let string = String(describing: value)
            bodyBuffer.writeString(CRLF)
            bodyBuffer.writeString("Content-Length: \(string.count)")
            bodyBuffer.writeString(CRLF+CRLF)
            bodyBuffer.writeString(string)
            bodyBuffer.writeString(CRLF)
        }

        let boundary = randomBoundary()
        var bodyBuffer = ByteBuffer()

        for (key, value) in params {
            switch key {
            case "file":
                addPart(name: key, value: value!)
            default:
                if let list = value as? [Any] {
                    for listValue in list {
                        addPart(name: "\(key)[]", value: listValue)
                    }
                    continue
                }
                addPart(name: key, value: value!)
            }
        }

        bodyBuffer.writeString(DASHDASH)
        bodyBuffer.writeString(boundary)
        bodyBuffer.writeString(DASHDASH)
        bodyBuffer.writeString(CRLF)

        request.headers.remove(name: "content-type")
        request.headers.add(name: "Content-Length", value: bodyBuffer.readableBytes.description)
        request.headers.add(name: "Content-Type", value: "multipart/form-data;boundary=\"\(boundary)\"")
        request.body = .byteBuffer(bodyBuffer)
    }
}

extension Client {

    public enum HTTPStatus: Int {
      case unknown = -1
      case ok = 200
      case created = 201
      case accepted = 202
      case movedPermanently = 301
      case found = 302
      case badRequest = 400
      case notAuthorized = 401
      case paymentRequired = 402
      case forbidden = 403
      case notFound = 404
      case methodNotAllowed = 405
      case notAcceptable = 406
      case internalServerError = 500
      case notImplemented = 501
    }
}
