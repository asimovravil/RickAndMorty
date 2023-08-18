//
//  Character .swift
//  RickAndMorty
//
//  Created by Ravil on 18.08.2023.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: URL
    let episode: [URL]
    let url: URL
    let created: String
}

