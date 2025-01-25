//
//  CatFactsModel.swift
//  CatFacts
//
//  Created by SOHAM PAUL on 25/01/25.
//

import Foundation

// MARK: - Models
struct CatFact: Decodable {
    let fact: [String]
    
    private enum CodingKeys: String,CodingKey {
        case fact = "data"
    }
}

struct CatImage: Decodable {
    let url: String
    
    private enum CodingKeys: String,CodingKey {
        case url = "url"
    }
}
