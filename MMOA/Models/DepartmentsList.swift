//
//  DepartmentsList.swift
//  MMOA
//
//  Created by Bakr mohamed on 17/06/2022.
//

import Foundation
// MARK: - DepartmentList
struct DepartmentList: Codable {
    let departments: [Department]?
}

// MARK: - Department
struct Department: Codable {
    let departmentID: Int?
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case departmentID = "departmentId"
        case displayName
    }
}

