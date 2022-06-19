//
//  MasterView.swift
//  

import SwiftUI

struct MasterView: View {
    @Preference(\.rootView) var rootView
    
    var body: some View {
        LocalizedContentView {
            rootView?.getRootView()
        }
    }
}
