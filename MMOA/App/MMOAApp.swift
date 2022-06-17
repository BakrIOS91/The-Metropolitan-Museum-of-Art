//
//  MMOAApp.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import SwiftUI

@main
struct MMOAApp: App {
    @Preference(\.locale) var locale

    
    init(){
        NetworkMonitor.shared.startMonitoring()
        self.locale = Locale(identifier: Bundle.main.preferredLocalizations.first ?? "en")
    }
    
    var body: some Scene {
        WindowGroup {
            MasterView()
        }
        
    }
}
