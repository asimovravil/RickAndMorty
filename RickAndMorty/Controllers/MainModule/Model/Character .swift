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
    let name: String
    let image: URL
}

