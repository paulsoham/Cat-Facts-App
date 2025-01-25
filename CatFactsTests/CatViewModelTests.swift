//
//  CatViewModelTests.swift
//  CatFactsTests
//
//  Created by SOHAM PAUL on 25/01/25.
//

import XCTest
@testable import CatFacts

class CatViewModelTests: XCTestCase {
    
    var viewModel: CatViewModel!
    var mockAPIService: MockAPIService!
    var mockImageService: MockImageService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        mockImageService = MockImageService()
        viewModel = CatViewModel(apiService: mockAPIService, imageService: mockImageService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        mockImageService = nil
        super.tearDown()
    }
    
    
    func testFetchCatContentSuccess() async {
        mockAPIService.shouldReturnError = false
        let imageData = Data([0x00, 0x01, 0x02])
        mockAPIService.mockData = imageData
        
        await viewModel.fetchCatContent()
        
        XCTAssertEqual(viewModel.catFact, "")
        XCTAssertNil(viewModel.catImage)
        XCTAssertEqual(viewModel.errorMessage, NSLocalizedString("decoding_error", comment: "Failed to load image"))
    }
    
    
    func testFetchCatContentFailure() async {
        mockAPIService.shouldReturnError = true
        
        await viewModel.fetchCatContent()
        
        XCTAssertEqual(viewModel.catFact, "")
        XCTAssertNil(viewModel.catImage)
        XCTAssertEqual(viewModel.errorMessage, NSLocalizedString("failed_to_load_content", comment: "Failed to load content"))
    }
    
    func testFetchCatContentFailure_ImageError() async {
        mockAPIService.shouldReturnError = false
        let imageData = Data([0x00, 0x01, 0x02])
        mockAPIService.mockData = imageData
        
        await viewModel.fetchCatContent()
        
        XCTAssertEqual(viewModel.catFact, "")
        XCTAssertNil(viewModel.catImage)
        XCTAssertEqual(viewModel.errorMessage, NSLocalizedString("decoding_error", comment: "Failed to load image"))
    }
}
