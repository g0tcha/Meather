//
//  WeatherRequest.swift
//  Meather
//
//  Created by Vincent Grossier on 06/05/2023.
//

import Foundation

enum OpenWeatherRequest: RemoteRequestProtocol {
    
    case current(lat: Double, lon: Double)
    
    var host: String {
        "api.openweathermap.org"
    }
    
    var path: String {
        "/data/2.5/weather"
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParameters: [String: String]? {
        switch self {
        case let .current(lat, lon):
            do {
                return [
                    "lat": String(lat),
                    "lon": String(lon),
                    "appid": try SecretsManager.getSecret(.openWeather),
                    "units": "metric"
                ]
            } catch {
                print("Something went wrong when reading secrets.\n", error.localizedDescription)
                return [:]
            }
        }
    }
}
