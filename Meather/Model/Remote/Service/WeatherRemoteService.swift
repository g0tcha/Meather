//
//  WeatherManager.swift
//  Meather
//
//  Created by Vincent Grossier on 06/05/2023.
//

import Foundation

protocol WeatherRemoteServiceAPI {
    func getCurrentWeather(latitude: Double, longitude: Double) async throws -> WeatherData
}

final class WeatherRemoteService {
    
    private let client: RemoteClientProtocol
    
    init(client: RemoteClientProtocol = URLSessionClient()) {
        self.client = client
    }
    
    func getCurrentWeather(latitude: Double, longitude: Double) async throws -> WeatherData {
        do {
            let data = try await client.perform(OpenWeatherRequest.current(lat: latitude, lon: longitude))
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
