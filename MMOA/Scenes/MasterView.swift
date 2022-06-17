//
//  MasterView.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
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
