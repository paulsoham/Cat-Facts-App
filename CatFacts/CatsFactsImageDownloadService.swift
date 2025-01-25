//
//  CatsFactsImageDownloadService.swift
//  CatFacts
//
//  Created by SOHAM PAUL on 25/01/25.
//

import UIKit

// MARK: - Image Service Protocol
protocol ImageServiceProtocol {
    func downloadImage(from urlString: String) async throws -> UIImage
}

// MARK: - Image Service Error
enum ImageServiceError: Error {
    case invalidURL
    case noData
    case networkError(Error)
    case decodingError
    case unknownError
}

// MARK: - Image Service Class
class ImageService: ImageServiceProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func downloadImage(from urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw ImageServiceError.invalidURL
        }
        do {
            let imageData: Data = try await apiService.fetchData(endpoint: url.absoluteString)
            guard let image = UIImage(data: imageData) else {
                throw ImageServiceError.decodingError
            }
            return image
        } catch let apiError as APIServiceError {
            throw ImageServiceError.networkError(apiError)
        } catch {
            throw ImageServiceError.unknownError
        }
    }
}
