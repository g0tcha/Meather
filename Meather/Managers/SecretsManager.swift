//
//  SecretsManager.swift
//  Meather
//
//  Created by Vincent Grossier on 06/05/2023.
//

import Foundation

final class SecretsManager {
    
    private static let fileName = "Secrets"
    private static let fileExtension = "plist"
    
    private enum SecretsManagerError: Error {
        case unableToLoadFile
        case secretNotFound
    }
    
    enum Secret: String {
        case openWeather = "openweather"
    }
    
    static func getSecret(_ secret: Secret) throws -> String {
        do {
            guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
                throw SecretsManagerError.unableToLoadFile
            }
            
            let data = try Data(contentsOf: fileUrl)
            let secrets = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: String]
            
            guard let secret = secrets?[secret.rawValue] else {
                throw SecretsManagerError.secretNotFound
            }
            
            return secret
        } catch {
            throw error
        }
    }
}
