//
//  ContentView.swift
//  Shared
//
//  Created by Jake Barnby on 3/08/21.
//
//

import SwiftUI
import Appwrite
import NIO

let host = "http://192.168.20.6:80/v1"
let projectId = "613b18dabf74a"

let client = Client()
    .setEndpoint(host)
    .setProject(projectId)

struct ContentView: View {
    
    let account = Account(client: client)
    let storage = Storage(client: client)
    let realtime = Realtime(client: client)
    
    @State var username: String = "test@test.test"
    @State var password: String = "password"
    @State var fileId: String = "614c1f5864841"
    @State var collectionId: String = "6149afd52ce3b"
    
    @State private var isShowPhotoLibrary = false
    @State private var imageToUpload = UIImage()
    @State private var response: String = ""
    @State private var downloadedImage: Image? = nil

    @ObservedObject var keyboard: Keyboard = .init()
    
    var body: some View {
        
        VStack(spacing: 8) {

            downloadedImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)

            TextEditor(text: $response)
                .padding()
                .padding(.bottom, keyboard.height)
                .edgesIgnoringSafeArea(keyboard.height > 0 ? .bottom : [])

            Button("Login") {
                login()
            }

            Button("Login with Facebook") {
                loginWithFacebook()
            }

            Button("Register") {
                register()
            }

            Button("Download image") {
                download()
            }
            
            Button("Upload image") {
                self.isShowPhotoLibrary = true
            }
            
            Button("Subscribe") {
                subscribe()
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$imageToUpload)
        }
        .onChange(of: imageToUpload) { img in
            upload(image: img)
        }
        .registerOAuthHandler()
    }
    
    func register() {
        account.create(username, password) { result in
            switch result {
            case .failure(let error): self.response = error.message
            case .success(var response): self.response = response.body!.readString(length: response.body!.readableBytes) ?? ""
            }
        }
    }
    
    func login() {
        account.createSession(username, password) { result in
            switch result {
            case .failure(let error): self.response = error.message
            case .success(var response): self.response = response.body!.readString(length: response.body!.readableBytes) ?? ""
            }
        }
    }
    
    func loginWithFacebook() {
        account.createOAuth2Session(
            "facebook",
            "\(host)/auth/oauth2/success",
            "\(host)/auth/oauth2/failure"
        ) { result in
            switch result {
            case .failure: self.response = "false"
            case .success(let response): self.response = response.description
            }
        }
    }
    
    func download() {
        storage.getFileDownload(fileId) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(var response):
                downloadedImage = Image(uiImage: UIImage(
                    data: response.body!.readData(
                        length: response.body!.readableBytes
                    )!
                )!)
            }
        }
    }
    
    func upload(image: UIImage) {
        let imageBuffer = ByteBufferAllocator()
            .buffer(data: image.jpegData(compressionQuality: 1)!)
            
        let file = File(
            name: "file.png",
            buffer: imageBuffer
        )
        
        storage.createFile(file) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(var response):
                self.response = response.body!.readString(length: response.body!.readableBytes) ?? ""
            }
        }
    }
    
    func subscribe() {
        _ = realtime.subscribe(channels: ["collections.\(collectionId).documents"], payloadType: Test.self) { message in
            print(String(describing: message))
        }
    }
}

class Test : Decodable {
    public let name: String
    public let description: String
    
    public init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
