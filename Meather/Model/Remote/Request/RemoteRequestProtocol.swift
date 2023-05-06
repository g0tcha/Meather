//
//  RemoteRequestProtocol.swift
//  Meather
//
//  Created by Vincent Grossier on 06/05/2023.
//

import Foundation

enum RemoteRequestError: Error {
    case badURL
}

protocol RemoteRequestProtocol {
    var host: String { get }
    var path: String { get }
    var requestType: RequestType { get }
    var urlParameters: [String: String]? { get }
    func asURLRequest() throws -> URLRequest
}

extension RemoteRequestProtocol {
    
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = HTTPScheme.https
        components.host = host
        components.path = path
        
        if let urlParameters {
            components.queryItems = urlParameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else {
            throw RemoteRequestError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
