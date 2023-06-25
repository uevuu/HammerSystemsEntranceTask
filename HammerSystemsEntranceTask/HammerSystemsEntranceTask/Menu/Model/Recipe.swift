//
//  Recipe.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 24.06.2023.
//

import Foundation

struct Recipe: Codable {
    let pricePerServing: Double
    let servings: Int
    let image: String?
    let title: String
    let sourceName: String
    let id: Int
}
