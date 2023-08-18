//
//  LocationService.swift
//  RickAndMorty
//
//  Created by Ravil on 18.08.2023.
//

import Foundation

class LocationService {
    static func fetchLocations(completion: @escaping ([Location]?, Error?) -> Void) {
        let apiUrl = "https://rickandmortyapi.com/api/location"
        
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching location data: \(error)")
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
                let locationResponse = try decoder.decode(LocationResponse.self, from: data)
                let locations = locationResponse.results
                completion(locations, nil)
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
