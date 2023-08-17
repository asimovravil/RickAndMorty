//
//  AppColor.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import Foundation
import UIKit

protocol AppColorProtocol {
    var rawValue: String { get }
}

extension AppColorProtocol {

    var uiColor: UIColor {
        guard let color = UIColor.init(named: rawValue) else {
            fatalError("Could not find color with name \(rawValue)")
        }
        return color
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

enum AppColor: String, AppColorProtocol {
    case blackBG
    case grayBG
    case grayNormalBG
    case primaryBG
    case whiteBG
}
