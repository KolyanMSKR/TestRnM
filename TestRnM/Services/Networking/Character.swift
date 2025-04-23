//
//  Character.swift
//  TestRnM
//
//  Created by Anderen on 04.04.2025.
//

import Foundation

struct CharacterResponse: Decodable {
    let info: PaginationInfo
    let results: [Character]
}

struct Character: Decodable {
    let id: Int32
    let name: String
    let species: String
    let image: String
    let status: Status
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

struct PaginationInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
