//
//  CatViewControllerTests.swift
//  CatFactsTests
//
//  Created by SOHAM PAUL on 25/01/25.
//

import XCTest
@testable import CatFacts

class CatViewControllerTests: XCTestCase {
    
    var viewController: CatViewController!
    var mockViewModel: MockCatViewModel!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockCatViewModel()
        viewController = CatViewController()
        viewController.viewModel = mockViewModel
    }
    
    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    @MainActor
    func testUpdateUIWithError() async {
        mockViewModel.errorMessage = "Error"
        
        viewController.updateUI()
        
        XCTAssertEqual(viewController.factLabel.text, "Error")
        XCTAssertEqual(viewController.factLabel.textColor, UIColor.systemRed)
    }
    
    @MainActor
    func testUpdateUIWithSuccess() async {
        mockViewModel.catFact = "Cat Fact"
        mockViewModel.catImage = UIImage(systemName: "star")
        
        viewController.updateUI()
        
        XCTAssertEqual(viewController.factLabel.text, "Cat Fact")
        XCTAssertEqual(viewController.factLabel.textColor, UIColor.label)
        XCTAssertNotNil(viewController.imageView.image)
    }
}
