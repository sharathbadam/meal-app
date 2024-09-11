//
//  NetworkManager.swift
//  Meal
//
//  Created by Sharath badam on 11/09/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed
    case decodingError
}

class NetworkManager {
    
    // Singleton instance (optional, based on your preference)
    static let shared = NetworkManager()
    
    private init() {}
    
    // Generic function to make network requests
    func request<T: Decodable>(
        urlString: String,
        responseType: T.Type,
        keyPath: String?
    ) async throws -> T {
        
        // Validate URL
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        // Perform the data request asynchronously
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check for valid response status code
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed
        }
        
        // Decode the response data
        do {
            if let keyPath = keyPath {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data, keyPath: keyPath)
                return decodedResponse
            }
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            print(error.localizedDescription)
            throw NetworkError.decodingError
        }
    }
}


extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String) throws -> T {
        let toplevel = try JSONSerialization.jsonObject(with: data)
        if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
            let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
            return try decode(type, from: nestedJsonData)
        } else {
            throw DecodingError.dataCorrupted(
                .init(
                    codingPath: [],
                    debugDescription: "Nested json not found for key path \"\(keyPath)\""
                )
            )
        }
    }
}
