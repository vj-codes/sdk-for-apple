```swift
import Appwrite

func main() {
    let client = Client()
      .setEndpoint("https://[HOSTNAME_OR_IP]/v1") // Your API Endpoint
      .setProject("5df5acd0d48c2") // Your project ID

    let avatars = Avatars(client: client)
    avatars.getImage(
        url: "https://example.com"
    ) { result in
        switch result {
        case .failure(let error):
            print(error)
        case .success(let response):
            print(result) // Resource URL
        }
    }
}
```