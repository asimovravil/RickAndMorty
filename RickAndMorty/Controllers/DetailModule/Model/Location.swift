//
//  Location.swift
//  RickAndMorty
//
//  Created by Ravil on 18.08.2023.
//

import Foundation

struct LocationResponse: Codable {
    let results: [Location]
}

struct LocationInfo: Codable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [URL]
    let url: URL
    let created: String
}
