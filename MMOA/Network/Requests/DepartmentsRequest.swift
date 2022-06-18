//
//  DepartmentsRequest.swift
//  MMOA
//
//  Created by Bakr mohamed on 17/06/2022.
//

import Foundation

enum DepartmentRequest: BaseRequestProtocol {    
    case getDepartmentsList
    
    var path: String {
        switch self {
        case .getDepartmentsList:
            return "/departments"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDepartmentsList:
            return .GET
        }
    }
}
