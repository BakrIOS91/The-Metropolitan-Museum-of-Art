//
//  DepartmentsRequest.swift
//  MMOA
//
//  Created by Bakr mohamed on 17/06/2022.
//

import Foundation

enum DepartmentRequest: BaseRequestProtocol {    
    case getDepartmentsList
    case getDepartmentDetails(id: Int, searchText: String)
    case getObjectDetails(id: Int)
    
    var path: String {
        switch self {
        case .getDepartmentsList:
            return "/departments"
        case .getDepartmentDetails(_,_):
            return "/search"
        case .getObjectDetails(let id):
            return "/objects/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .getDepartmentDetails(let id, let searchText):
            return [
                "departmentIds" : id,
                "q": searchText,
                "hasImages": true
            ]
            
        default:
            return [:]
        }
    }
}
