//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Ravil on 18.08.2023.
//

import Foundation

class CharacterService {
    static func fetchCharacters(completion: @escaping ([Character]?, Error?) -> Void) {
        let apiUrl = "https://rickandmortyapi.com/api/character"
        
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching character data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characterResponse = try decoder.decode(CharacterResponse.self, from: data)
                let characters = characterResponse.results
                completion(characters, nil)
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}

