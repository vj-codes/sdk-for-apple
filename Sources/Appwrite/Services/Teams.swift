import AsyncHTTPClient
import Foundation
import NIO

open class Teams: Service {
    ///
    /// List Teams
    ///
    /// Get a list of all the current user teams. You can use the query params to
    /// filter your results. On admin mode, this endpoint will return a list of all
    /// of the project's teams. [Learn more about different API
    /// modes](/docs/admin).
    ///
    /// @param String search
    /// @param Int limit
    /// @param Int offset
    /// @param String orderType
    /// @throws Exception
    /// @return array
    ///
    open func list(_ search: String = "", _ limit: Int = 25, _ offset: Int = 0, _ orderType: String = "ASC", completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/teams"

        let params: [String: Any?] = [
            "search": search,
            "limit": limit,
            "offset": offset,
            "orderType": orderType
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Team
    ///
    /// Create a new team. The user who creates the team will automatically be
    /// assigned as the owner of the team. The team owner can invite new members,
    /// who will be able add new owners and update or delete the team from your
    /// project.
    ///
    /// @param String name
    /// @param Array<Any>? roles
    /// @throws Exception
    /// @return array
    ///
    open func create(_ name: String, _ roles: Array<Any>? = nil, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/teams"

        let params: [String: Any?] = [
            "name": name,
            "roles": roles
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "POST", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Get Team
    ///
    /// Get a team by its unique ID. All team members have read access for this
    /// resource.
    ///
    /// @param String teamId
    /// @throws Exception
    /// @return array
    ///
    open func get(_ teamId: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/teams/{teamId}"

        path = path.replacingOccurrences(
          of: "{teamId}",
          with: teamId
        )

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Update Team
    ///
    /// Update a team by its unique ID. Only team owners have write access for this
    /// resource.
    ///
    /// @param String teamId
    /// @param String name
    /// @throws Exception
    /// @return array
    ///
    open func update(_ teamId: String, _ name: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/teams/{teamId}"

        path = path.replacingOccurrences(
          of: "{teamId}",
          with: teamId
        )

        let params: [String: Any?] = [
            "name": name
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PUT", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Delete Team
    ///
    /// Delete a team by its unique ID. Only team owners have write access for this
    /// resource.
    ///
    /// @param String teamId
    /// @throws Exception
    /// @return array
    ///
    open func delete(_ teamId: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/teams/{teamId}"

        path = path.replacingOccurrences(
          of: "{teamId}",
          with: teamId
        )

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "DELETE", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Get Team Memberships
    ///
    /// Get a team members by the team unique ID. All team members have read access
    /// for this list of resources.
    ///
    /// @param String teamId
    /// @param String search
    /// @param Int limit
    /// @param Int offset
    /// @param String orderType
    /// @throws Exception
    /// @return array
    ///
    open func getMemberships(_ teamId: String, _ search: String = "", _ limit: Int = 25, _ offset: Int = 0, _ orderType: String = "ASC", completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/teams/{teamId}/memberships"

        path = path.replacingOccurrences(
          of: "{teamId}",
          with: teamId
        )

        let params: [String: Any?] = [
            "search": search,
            "limit": limit,
            "offset": offset,
            "orderType": orderType
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Create Team Membership
    ///
    /// Use this endpoint to invite a new member to join your team. An email with a
    /// link to join the team will be sent to the new member email address if the
    /// member doesn't exist in the project it will be created automatically.
    /// 
    /// Use the 'URL' parameter to redirect the user from the invitation email back
    /// to your app. When the user is redirected, use the [Update Team Membership
    /// Status](/docs/client/teams#teamsUpdateMembershipStatus) endpoint to allow
    /// the user to accept the invitation to the team.
    /// 
    /// Please note that in order to avoid a [Redirect
    /// Attacks](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.md)
    /// the only valid redirect URL's are the once from domains you have set when
    /// added your platforms in the console interface.
    ///
    /// @param String teamId
    /// @param String email
    /// @param Array<Any>? roles
    /// @param String url
    /// @param String name
    /// @throws Exception
    /// @return array
    ///
    open func createMembership(_ teamId: String, _ email: String, _ roles: Array<Any>?, _ url: String, _ name: String = "", completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/teams/{teamId}/memberships"

        path = path.replacingOccurrences(
          of: "{teamId}",
          with: teamId
        )

        let params: [String: Any?] = [
            "email": email,
            "name": name,
            "roles": roles,
            "url": url
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "POST", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Update Membership Roles
    ///
    /// @param String teamId
    /// @param String membershipId
    /// @param Array<Any>? roles
    /// @throws Exception
    /// @return array
    ///
    open func updateMembershipRoles(_ teamId: String, _ membershipId: String, _ roles: Array<Any>?, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/teams/{teamId}/memberships/{membershipId}"

        path = path.replacingOccurrences(
          of: "{teamId}",
          with: teamId
        )

        path = path.replacingOccurrences(
          of: "{membershipId}",
          with: membershipId
        )

        let params: [String: Any?] = [
            "roles": roles
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PATCH", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Delete Team Membership
    ///
    /// This endpoint allows a user to leave a team or for a team owner to delete
    /// the membership of any other team member. You can also use this endpoint to
    /// delete a user membership even if it is not accepted.
    ///
    /// @param String teamId
    /// @param String membershipId
    /// @throws Exception
    /// @return array
    ///
    open func deleteMembership(_ teamId: String, _ membershipId: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/teams/{teamId}/memberships/{membershipId}"

        path = path.replacingOccurrences(
          of: "{teamId}",
          with: teamId
        )

        path = path.replacingOccurrences(
          of: "{membershipId}",
          with: membershipId
        )

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "DELETE", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// Update Team Membership Status
    ///
    /// Use this endpoint to allow a user to accept an invitation to join a team
    /// after being redirected back to your app from the invitation email recieved
    /// by the user.
    ///
    /// @param String teamId
    /// @param String membershipId
    /// @param String userId
    /// @param String secret
    /// @throws Exception
    /// @return array
    ///
    open func updateMembershipStatus(_ teamId: String, _ membershipId: String, _ userId: String, _ secret: String, completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        var path: String = "/teams/{teamId}/memberships/{membershipId}/status"

        path = path.replacingOccurrences(
          of: "{teamId}",
          with: teamId
        )

        path = path.replacingOccurrences(
          of: "{membershipId}",
          with: membershipId
        )

        let params: [String: Any?] = [
            "userId": userId,
            "secret": secret
        ]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "PATCH", path: path, headers: headers, params: params, completion: completion)
    }

}
