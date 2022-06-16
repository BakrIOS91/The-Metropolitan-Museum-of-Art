//
//  MMOAApp.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import SwiftUI

@main
struct MMOAApp: App {
    
    init(){
        NetworkMonitor.shared.startMonitoring()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
