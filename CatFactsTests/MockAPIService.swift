//
//  MockAPIService.swift
//  CatFactsTests
//
//  Created by SOHAM PAUL on 25/01/25.
//
import UIKit
import Foundation

@testable import CatFacts

class MockAPIService: APIServiceProtocol {
    var shouldReturnError = false
    var mockData: Data?
    var mockError: Error?
    
    func fetchData<T: Decodable>(endpoint: String) async throws -> T {
        if shouldReturnError {
            if let error = mockError {
                throw error
            } else {
                throw APIServiceError.networkError(NSError(domain: "NetworkError", code: 1, userInfo: nil))
            }
        }
        if let mockData = mockData {
            let decoder = JSONDecoder()
            if T.self == Data.self {
                return mockData as! T
            }
            return try decoder.decode(T.self, from: mockData)
        }
        throw APIServiceError.noData
    }
}



class MockImageService: ImageServiceProtocol {
    func downloadImage(from urlString: String) async throws -> UIImage {
        return UIImage(systemName: "star")!
    }
}

