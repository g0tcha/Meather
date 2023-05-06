//
//  URLSessionClient.swift
//  Meather
//
//  Created by Vincent Grossier on 06/05/2023.
//

import Foundation

final class URLSessionClient: RemoteClientProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func perform(_ request: RemoteRequestProtocol) async throws -> Data {
        let (data, response) = try await session.data(for: request.asURLRequest())
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == HTTPStatusCode.OK
        else {
            throw RemoteClientError.unexpectedResponse
        }
        
        return data
    }
}
