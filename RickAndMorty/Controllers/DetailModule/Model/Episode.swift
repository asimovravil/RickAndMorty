//
//  Episode.swift
//  RickAndMorty
//
//  Created by Ravil on 18.08.2023.
//

import Foundation

struct EpisodeResponse: Codable {
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [URL]
    let url: URL
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}


