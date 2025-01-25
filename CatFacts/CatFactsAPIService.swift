//
//  CatFactsAPIService.swift
//  CatFacts
//
//  Created by SOHAM PAUL on 25/01/25.
//

import Foundation

// MARK: - API Service Protocol
protocol APIServiceProtocol {
    func fetchData<T: Decodable>(endpoint: String) async throws -> T
}

// MARK: - API Service Error
enum APIServiceError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case noData
    case imageDownloadError(NSError) 
}

// MARK: - API Service Class
class APIService: APIServiceProtocol {
    func fetchData<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIServiceError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard !data.isEmpty else {
                throw APIServiceError.noData
            }
            if T.self == Data.self {
                return data as! T
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIServiceError.networkError(error)
        }
    }
}
