//
//  APIServiceTests.swift
//  CatFactsTests
//
//  Created by SOHAM PAUL on 25/01/25.
//

import XCTest
@testable import CatFacts

class APIServiceTests: XCTestCase {
    
    var apiService: APIService!
    
    override func setUp() {
        super.setUp()
        apiService = APIService()
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    func testFetchDataValidURL() async throws {
        let endpoint = "https://meowfacts.herokuapp.com/"
        let result: CatFact = try await apiService.fetchData(endpoint: endpoint)
        XCTAssertFalse(result.fact.isEmpty, "Cat fact should not be empty.")
    }
    
    func testFetchDataInvalidURL() async throws {
        let endpoint = "invalid_url"
        do {
            _ = try await apiService.fetchData(endpoint: endpoint) as CatFact
            XCTFail("Expected to throw networkError.")
        } catch let error as APIServiceError {
            if case .networkError(_) = error {
                XCTAssertEqual(true, true, "Expected networkError.")
            } else {
                XCTFail("Expected networkError, but got \(error) instead.")
            }
        }
    }
    
    func testFetchDataNoData() async throws {
        let endpoint = "https://meowfacts.herokuapp.com/empty"
        do {
            _ = try await apiService.fetchData(endpoint: endpoint) as CatFact
            XCTFail("Expected to throw networkError.")
        } catch let error as APIServiceError {
            if case .networkError(let underlyingError) = error,
               let decodingError = underlyingError as? DecodingError {
                print("Decoding error: \(decodingError)")
                XCTAssertEqual(true, true, "Expected networkError with DecodingError.")
            } else {
                XCTFail("Expected networkError with DecodingError, but got \(error) instead.")
            }
        }
    }
    
    func testFetchDataDecodingError() async throws {
        let endpoint = "https://meowfacts.herokuapp.com/invalidjson"
        do {
            _ = try await apiService.fetchData(endpoint: endpoint) as CatFact
            XCTFail("Expected to throw networkError.")
        } catch let error as APIServiceError {
            if case .networkError(let underlyingError) = error,
               let decodingError = underlyingError as? DecodingError {
                print("Decoding error: \(decodingError)")
                XCTAssertEqual(true, true, "Expected networkError with DecodingError.")
            } else {
                XCTFail("Expected networkError with DecodingError, but got \(error) instead.")
            }
        }
    }
}
