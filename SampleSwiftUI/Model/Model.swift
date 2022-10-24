//
//  Model.swift
//  SampleSwiftUI
//
//  Created by mtanaka on 2022/10/24.
//

import Foundation

struct Model: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    struct Item: Codable, Equatable, Identifiable {
        let id: Int
        let fullName: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case fullName = "full_name"
        }
    }
}
