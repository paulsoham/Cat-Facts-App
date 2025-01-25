//
//  MockCatViewModel.swift
//  CatFactsTests
//
//  Created by SOHAM PAUL on 25/01/25.
//

import UIKit
import Foundation

@testable import CatFacts

class MockCatViewModel: CatViewModel {
    override func fetchCatContent() async {
        catFact = "Cat Fact"
        catImage = UIImage(systemName: "star")
        errorMessage = nil
    }
}
