//
//  DepartmentCell.swift
//  MMOA
//
//  Created by Bakr mohamed on 18/06/2022.
//

import SwiftUI

struct DepartmentCell: View {
    var title: String = "Test"
    var body: some View {
        NavigationLink {
            Text(title)
        } label: {
            ZStack(alignment: .leading) {
                Color.cyan.opacity(0.4).ignoresSafeArea().cornerRadius(10)
                HStack(spacing: 10){
                    Text(title)
                        .font(AppFont.mediumWithSize14)
                        .multilineTextAlignment(.leading)
    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                }
                .padding()
            }
        }
        .padding(.horizontal, 20)
        
    }
}
