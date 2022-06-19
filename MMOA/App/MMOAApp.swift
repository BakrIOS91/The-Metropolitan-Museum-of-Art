//
//  MMOAApp.swift
//  

import SwiftUI
import netfox

@main
struct MMOAApp: App {
    @Preference(\.locale) var locale

    
    init(){
        NFX.sharedInstance().start() // for testing only should be removed in live version
        NetworkMonitor.shared.startMonitoring()
        self.locale = Locale(identifier: Bundle.main.preferredLocalizations.first ?? "en")
    }
    
    var body: some Scene {
        WindowGroup {
            MasterView()
        }
        
    }
}
