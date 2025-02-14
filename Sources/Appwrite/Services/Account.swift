import AsyncHTTPClient
import Foundation
import NIO

open class Account: Service {
    ///
    /// Get Account
    ///
    /// Get currently logged in user data as JSON object.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func get(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Account
    ///
    /// Use this endpoint to allow a new user to register a new account in your
    /// project. After the user registration completes successfully, you can use
    /// the [/account/verfication](/docs/client/account#accountCreateVerification)
    /// route to start verifying the user email address. To allow the new user to
    /// login to their new account, you need to create a new [account
    /// session](/docs/client/account#accountCreateSession).
    ///
    /// @param String email
    /// @param String password
    /// @param String name
    /// @throws Exception
    /// @return array
    ///
    open func create(_ email: String, _ password: String, _ name: String = "", completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account"

        let params: [String: Any?] = [
            "email": email,
            "password": password,
            "name": name
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "POST", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Delete Account
    ///
    /// Delete a currently logged in user account. Behind the scene, the user
    /// record is not deleted but permanently blocked from any access. This is done
    /// to avoid deleted accounts being overtaken by new users with the same email
    /// address. Any user-related resources like documents or storage files should
    /// be deleted separately.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func delete(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "DELETE", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Update Account Email
    ///
    /// Update currently logged in user account email address. After changing user
    /// address, user confirmation status is being reset and a new confirmation
    /// mail is sent. For security measures, user password is required to complete
    /// this request.
    /// This endpoint can also be used to convert an anonymous account to a normal
    /// one, by passing an email address and a new password.
    ///
    /// @param String email
    /// @param String password
    /// @throws Exception
    /// @return array
    ///
    open func updateEmail(_ email: String, _ password: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/email"

        let params: [String: Any?] = [
            "email": email,
            "password": password
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PATCH", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Account JWT
    ///
    /// Use this endpoint to create a JSON Web Token. You can use the resulting JWT
    /// to authenticate on behalf of the current user when working with the
    /// Appwrite server-side API and SDKs. The JWT secret is valid for 15 minutes
    /// from its creation and will be invalid if the user will logout.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func createJWT(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/jwt"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "POST", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Get Account Logs
    ///
    /// Get currently logged in user list of latest security activity logs. Each
    /// log returns user IP address, location and date and time of log.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getLogs(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/logs"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Update Account Name
    ///
    /// Update currently logged in user account name.
    ///
    /// @param String name
    /// @throws Exception
    /// @return array
    ///
    open func updateName(_ name: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/name"

        let params: [String: Any?] = [
            "name": name
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PATCH", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Update Account Password
    ///
    /// Update currently logged in user password. For validation, user is required
    /// to pass in the new password, and the old password. For users created with
    /// OAuth and Team Invites, oldPassword is optional.
    ///
    /// @param String password
    /// @param String oldPassword
    /// @throws Exception
    /// @return array
    ///
    open func updatePassword(_ password: String, _ oldPassword: String = "", completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/password"

        let params: [String: Any?] = [
            "password": password,
            "oldPassword": oldPassword
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PATCH", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Get Account Preferences
    ///
    /// Get currently logged in user preferences as a key-value object.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getPrefs(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/prefs"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Update Account Preferences
    ///
    /// Update currently logged in user account preferences. You can pass only the
    /// specific settings you wish to update.
    ///
    /// @param Any? prefs
    /// @throws Exception
    /// @return array
    ///
    open func updatePrefs(_ prefs: Any?, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/prefs"

        let params: [String: Any?] = [
            "prefs": prefs
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PATCH", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Password Recovery
    ///
    /// Sends the user an email with a temporary secret key for password reset.
    /// When the user clicks the confirmation link he is redirected back to your
    /// app password reset URL with the secret key and email address values
    /// attached to the URL query string. Use the query string params to submit a
    /// request to the [PUT
    /// /account/recovery](/docs/client/account#accountUpdateRecovery) endpoint to
    /// complete the process. The verification link sent to the user's email
    /// address is valid for 1 hour.
    ///
    /// @param String email
    /// @param String url
    /// @throws Exception
    /// @return array
    ///
    open func createRecovery(_ email: String, _ url: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/recovery"

        let params: [String: Any?] = [
            "email": email,
            "url": url
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "POST", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Complete Password Recovery
    ///
    /// Use this endpoint to complete the user account password reset. Both the
    /// **userId** and **secret** arguments will be passed as query parameters to
    /// the redirect URL you have provided when sending your request to the [POST
    /// /account/recovery](/docs/client/account#accountCreateRecovery) endpoint.
    /// 
    /// Please note that in order to avoid a [Redirect
    /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md)
    /// the only valid redirect URLs are the ones from domains you have set when
    /// adding your platforms in the console interface.
    ///
    /// @param String userId
    /// @param String secret
    /// @param String password
    /// @param String passwordAgain
    /// @throws Exception
    /// @return array
    ///
    open func updateRecovery(_ userId: String, _ secret: String, _ password: String, _ passwordAgain: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/recovery"

        let params: [String: Any?] = [
            "userId": userId,
            "secret": secret,
            "password": password,
            "passwordAgain": passwordAgain
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PUT", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Get Account Sessions
    ///
    /// Get currently logged in user list of active sessions across different
    /// devices.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getSessions(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/sessions"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Account Session
    ///
    /// Allow the user to login into their account by providing a valid email and
    /// password combination. This route will create a new session for the user.
    ///
    /// @param String email
    /// @param String password
    /// @throws Exception
    /// @return array
    ///
    open func createSession(_ email: String, _ password: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/sessions"

        let params: [String: Any?] = [
            "email": email,
            "password": password
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "POST", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Delete All Account Sessions
    ///
    /// Delete all sessions from the user account and remove any sessions cookies
    /// from the end client.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func deleteSessions(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/sessions"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "DELETE", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Anonymous Session
    ///
    /// Use this endpoint to allow a new user to register an anonymous account in
    /// your project. This route will also create a new session for the user. To
    /// allow the new user to convert an anonymous account to a normal account
    /// account, you need to update its [email and
    /// password](/docs/client/account#accountUpdateEmail).
    ///
    /// @throws Exception
    /// @return array
    ///
    open func createAnonymousSession(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/sessions/anonymous"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "POST", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Account Session with OAuth2
    ///
    /// Allow the user to login to their account using the OAuth2 provider of their
    /// choice. Each OAuth2 provider should be enabled from the Appwrite console
    /// first. Use the success and failure arguments to provide a redirect URL's
    /// back to your app when login is completed.
    ///
    /// @param String provider
    /// @param String success
    /// @param String failure
    /// @param Array<Any>? scopes
    /// @throws Exception
    /// @return array
    ///
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    open func createOAuth2Session(_ provider: String, _ success: String = "https://appwrite.io/auth/oauth2/success", _ failure: String = "https://appwrite.io/auth/oauth2/failure", _ scopes: Array<Any>? = nil, completion: ((Result<Bool, AppwriteError>) -> Void)? = nil) {
        var path: String = "/account/sessions/oauth2/{provider}"

        path = path.replacingOccurrences(
          of: "{provider}",
          with: provider
        )

        let params: [String: Any?] = [
            "success": success,
            "failure": failure,
            "scopes": scopes,
            "project": client.config["project"]
        ]

        let query = "?\(client.parametersToQueryString(params: params))"
        let url = URL(string: client.endPoint + path + query)!
        let callbackScheme = "appwrite-callback-\(client.config["project"] ?? "")"

        WebAuthComponent.authenticate(url: url, callbackScheme: callbackScheme) { result in
            guard let completion = completion else {
                return
            }
            completion(result.map { _ in true })
        }
    }

    ///
    /// Delete Account Session
    ///
    /// Use this endpoint to log out the currently logged in user from all their
    /// account sessions across all of their different devices. When using the
    /// option id argument, only the session unique ID provider will be deleted.
    ///
    /// @param String sessionId
    /// @throws Exception
    /// @return array
    ///
    open func deleteSession(_ sessionId: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/account/sessions/{sessionId}"

        path = path.replacingOccurrences(
          of: "{sessionId}",
          with: sessionId
        )

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "DELETE", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Email Verification
    ///
    /// Use this endpoint to send a verification message to your user email address
    /// to confirm they are the valid owners of that address. Both the **userId**
    /// and **secret** arguments will be passed as query parameters to the URL you
    /// have provided to be attached to the verification email. The provided URL
    /// should redirect the user back to your app and allow you to complete the
    /// verification process by verifying both the **userId** and **secret**
    /// parameters. Learn more about how to [complete the verification
    /// process](/docs/client/account#accountUpdateVerification). The verification
    /// link sent to the user's email address is valid for 7 days.
    /// 
    /// Please note that in order to avoid a [Redirect
    /// Attack](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md),
    /// the only valid redirect URLs are the ones from domains you have set when
    /// adding your platforms in the console interface.
    /// 
    ///
    /// @param String url
    /// @throws Exception
    /// @return array
    ///
    open func createVerification(_ url: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/verification"

        let params: [String: Any?] = [
            "url": url
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "POST", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Complete Email Verification
    ///
    /// Use this endpoint to complete the user email verification process. Use both
    /// the **userId** and **secret** parameters that were attached to your app URL
    /// to verify the user email ownership. If confirmed this route will return a
    /// 200 status code.
    ///
    /// @param String userId
    /// @param String secret
    /// @throws Exception
    /// @return array
    ///
    open func updateVerification(_ userId: String, _ secret: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/account/verification"

        let params: [String: Any?] = [
            "userId": userId,
            "secret": secret
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PUT", path: path, headers: headers, params: params, completion: completion)
    }

}
