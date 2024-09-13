//
//  Individuals.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import Foundation

// MARK: - Individuals
struct Individual: Codable {
    let id: Int
    let createdAt, name, sex: String
    let pictures: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name, sex, pictures
    }
}

typealias Individuals = [Individual]
