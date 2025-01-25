//
//  CatFactsViewModel.swift
//  CatFacts
//
//  Created by SOHAM PAUL on 25/01/25.
//

import Foundation
import UIKit

let CAT_FACT_ENDPOINT = "https://meowfacts.herokuapp.com/"
let CAT_IMAGE_ENDPOINT = "https://api.thecatapi.com/v1/images/search"

// MARK: - View Model
class CatViewModel {
    private let apiService: APIServiceProtocol
    private let imageService: ImageServiceProtocol
    
    @Published var catFact: String = ""
    @Published var catImage: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(apiService: APIServiceProtocol = APIService(), imageService: ImageServiceProtocol = ImageService()) {
        self.apiService = apiService
        self.imageService = imageService
    }
    
    func fetchCatContent() async {
        isLoading = true
        errorMessage = nil
        do {
            let catFactResponse: CatFact = try await apiService.fetchData(endpoint: CAT_FACT_ENDPOINT)
            catFact = catFactResponse.fact.first ?? NSLocalizedString("no_fact_available", comment: "No fact available")
            
            let catImageResponse: [CatImage] = try await apiService.fetchData(endpoint: CAT_IMAGE_ENDPOINT)
            guard let imageURLString = catImageResponse.first?.url else {
                throw APIServiceError.imageDownloadError(NSError(domain: "ImageDownloadError", code: 1, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("failed_to_load_image", comment: "Failed to load image")]))
            }
            catImage = try await imageService.downloadImage(from: imageURLString)
        } catch {
            switch error {
            case is URLError:
                errorMessage = NSLocalizedString("network_error", comment: "Network error")
            case is DecodingError:
                errorMessage = NSLocalizedString("decoding_error", comment: "Decoding error")
            default:
                errorMessage = NSLocalizedString("failed_to_load_content", comment: "Failed to load content")
            }
        }
        isLoading = false
    }
    
}
