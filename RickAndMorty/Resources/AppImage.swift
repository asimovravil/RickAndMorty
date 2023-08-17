//
//  AppImage.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import Foundation
import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {

    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
}

enum AppImage: String, AppImageProtocol {
    
    // MARK: - LaunchScreen
    
    case rickandmorty
    case logolaunchscreen
    case framelaunchscreen
    case splashscreen

    
    // MARK: - MainScreen
    
    case rick
    case morty
    case summer
    case beth
    
}
