//
//  AppRootView.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import Foundation
import SwiftUI

func setAppRootView<view>(view: view) where view: View{
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    if let window = windowScene?.windows.first {
        window.rootViewController = UIHostingController(rootView: view)
        window.makeKeyAndVisible()
    }
}
