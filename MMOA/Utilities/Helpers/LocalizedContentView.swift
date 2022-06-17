//
//  LocalizedContentView.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import SwiftUI
struct LocalizedContentView<Content: View>: View {
    
    @Preference(\.locale) var locale
    var content: () -> Content
    
    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    var body: some View {
        content()
            .if(let: locale) { $0.locale($1) }
    }
}
