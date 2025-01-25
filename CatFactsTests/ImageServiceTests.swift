//
//  ImageServiceTests.swift
//  CatFactsTests
//
//  Created by SOHAM PAUL on 25/01/25.
//

import XCTest
@testable import CatFacts


class ImageServiceTests: XCTestCase {
    
    var imageService: ImageService!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        imageService = ImageService(apiService: mockAPIService)
    }
    
    
    func testDownloadImageSuccess() async throws {
        let imageData = UIImage(systemName: "star")!.pngData()!
        mockAPIService.mockData = imageData
        let image = try await imageService.downloadImage(from: "https://example.com/image.jpg")
        XCTAssertNotNil(image)
    }
    
    
    func testDownloadImageFailureInvalidURL() async throws {
        do {
            _ = try await imageService.downloadImage(from: " invalid url ")
            XCTFail("Expected ImageServiceError.networkError with APIServiceError.noData")
        } catch let error as ImageServiceError {
            if case .networkError(let nestedError) = error,
               case .noData = nestedError as? APIServiceError {
                XCTAssertEqual(true, true, "Expected ImageServiceError.networkError with APIServiceError.noData")
            } else {
                XCTFail("Expected ImageServiceError.networkError with APIServiceError.noData, but got \(error) instead")
            }
        }
    }
    
    
    func testDownloadImageFailureNoData() async throws {
        mockAPIService.shouldReturnError = true
        mockAPIService.mockError = APIServiceError.noData
        do {
            _ = try await imageService.downloadImage(from: "https://example.com/image.jpg")
            XCTFail("Expected ImageServiceError.networkError")
        } catch let error as ImageServiceError {
            if case .networkError = error {
                XCTAssertEqual(true, true, "Expected ImageServiceError.networkError")
            } else {
                XCTFail("Expected ImageServiceError.networkError, but got \(error) instead")
            }
        }
    }
    
    
    func testDownloadImageFailureNetworkError() async throws {
        mockAPIService.shouldReturnError = true
        mockAPIService.mockError = APIServiceError.networkError(NSError(domain: "NetworkError", code: 1, userInfo: nil))
        do {
            _ = try await imageService.downloadImage(from: "https://example.com/image.jpg")
            XCTFail("Expected ImageServiceError.networkError")
        } catch let error as ImageServiceError {
            if case .networkError = error {
                XCTAssertEqual(true, true, "Expected ImageServiceError.networkError")
            } else {
                XCTFail("Expected ImageServiceError.networkError, but got \(error) instead")
            }
        }
    }
    
    
    func testDownloadImageFailureDecodingError() async throws {
        let imageData = Data([0x00, 0x01, 0x02])
        mockAPIService.mockData = imageData
        do {
            _ = try await imageService.downloadImage(from: "https://example.com/image.jpg")
            XCTFail("Expected ImageServiceError.unknownError")
        } catch let error as ImageServiceError {
            if case .unknownError = error {
                XCTAssertEqual(true, true, "Expected ImageServiceError.unknownError")
            } else {
                XCTFail("Expected ImageServiceError.unknownError, but got \(error) instead")
            }
        }
    }
}
