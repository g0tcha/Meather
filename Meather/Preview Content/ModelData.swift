//
//  ModelData.swift
//  Meather
//
//  Created by Vincent Grossier on 06/05/2023.
//

import Foundation

var previewWeather: ResponseBody = load("weather_data")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("Couldn't find \(filename) in main bundle")
    }
    
    do {
        data = try Data(contentsOf: fileUrl)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error.localizedDescription)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self)\n\(error.localizedDescription)")
    }
}
