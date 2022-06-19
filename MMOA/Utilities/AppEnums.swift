//
//  AppEnums.swift
//  

import Foundation
import SwiftUI

enum RootView: Codable {
    case splash
    case language
    case home
    
    @ViewBuilder
    func getRootView() -> some View {
        switch self {
        case .splash:
            SplashView()
        case .language:
            LanguageSelectionView()
        case .home:
            TabBarView()
        }
    }
}
