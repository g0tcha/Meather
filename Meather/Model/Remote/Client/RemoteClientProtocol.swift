//
//  Client.swift
//  Meather
//
//  Created by Vincent Grossier on 06/05/2023.
//

import Foundation

enum RemoteClientError: Error {
    case badURL
    case unexpectedResponse
}

enum RequestType: String {
    case GET
    case POST
}

enum HTTPScheme {
    static let https = "https"
}

enum HTTPStatusCode {
    static let OK = 200
}

protocol RemoteClientProtocol {
    func perform(_ request: RemoteRequestProtocol) async throws -> Data
}
