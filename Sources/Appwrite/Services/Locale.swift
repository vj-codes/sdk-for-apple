import AsyncHTTPClient
import Foundation
import NIO

open class Locale: Service {
    ///
    /// Get User Locale
    ///
    /// Get the current user location based on IP. Returns an object with user
    /// country code, country name, continent name, continent code, ip address and
    /// suggested currency. You can use the locale header to get the data in a
    /// supported language.
    /// 
    /// ([IP Geolocation by DB-IP](https://db-ip.com))
    ///
    /// @throws Exception
    /// @return array
    ///
    open func get(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/locale"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// List Continents
    ///
    /// List of all continents. You can use the locale header to get the data in a
    /// supported language.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getContinents(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/locale/continents"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// List Countries
    ///
    /// List of all countries. You can use the locale header to get the data in a
    /// supported language.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getCountries(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/locale/countries"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// List EU Countries
    ///
    /// List of all countries that are currently members of the EU. You can use the
    /// locale header to get the data in a supported language.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getCountriesEU(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/locale/countries/eu"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// List Countries Phone Codes
    ///
    /// List of all countries phone codes. You can use the locale header to get the
    /// data in a supported language.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getCountriesPhones(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/locale/countries/phones"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// List Currencies
    ///
    /// List of all currencies, including currency symbol, name, plural, and
    /// decimal digits for all major and minor currencies. You can use the locale
    /// header to get the data in a supported language.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getCurrencies(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/locale/currencies"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

    ///
    /// List Languages
    ///
    /// List of all languages classified by ISO 639-1 including 2-letter code, name
    /// in English, and name in the respective language.
    ///
    /// @throws Exception
    /// @return array
    ///
    open func getLanguages(completion: ((Result<HTTPClient.Response, AppwriteError>) -> Void)? = nil) {
        let path: String = "/locale/languages"

        let params: [String: Any?] = [:]

        let headers: [String: String] = [
            "content-type": "application/json"
        ]

        client.call(method: "GET", path: path, headers: headers, params: params, completion: completion)
    }

}
