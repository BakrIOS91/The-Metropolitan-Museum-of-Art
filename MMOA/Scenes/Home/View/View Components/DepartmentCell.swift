//
//  DepartmentCell.swift
// 

import SwiftUI

struct DepartmentCell: View {
    var department: Department
    
    var body: some View {
        NavigationLink {
            DepartmentDetailsView(departmentId: department.departmentID ?? 1)
        } label: {
            Text(department.displayName ?? "")
                .font(AppFont.mediumWithSize16)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        
    }
}
