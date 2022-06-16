//
//  StringExtension.swift
//  WeatherApp
//
//  Created by Bakr mohamed on 08/05/2022.
//

import SwiftUI

extension String {
    
    var localizedStringKey: LocalizedStringKey {
        .init(self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
