//
//  AppEnums.swift
//  WeatherApp
//
//  Created by Bakr mohamed on 10/05/2022.
//

import Foundation


enum AppLanguage: Equatable {
    case english
    case deutsch
    
    var laungageCode: String {
        switch self {
        case .english:
            return "en"
        case .deutsch:
            return "de"
        }
    }
}
