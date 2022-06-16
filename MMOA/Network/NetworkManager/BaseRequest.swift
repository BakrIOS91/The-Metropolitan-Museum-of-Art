//
//  BaseRequest.swift
//  MVVMCAppStructure
//
//  Created by Bakr mohamed on 03/04/2022.
//

import Foundation

typealias Parameters = [String:String]
typealias MultipartAttachment = (fileName: String, url: URL?, data: Data?)

protocol BaseRequestProtocol {
    var host: String {get}
    var path: String {get}
    var headers: [String: String] {get}
    var baseHeaders : [String: String] {get}
    var requestTimeOut: Float {get}
    var httpMethod: HTTPMethod {get}
    var parameters: Parameters? {get}
}

extension BaseRequestProtocol {
    var host: String {return kBaseURL}
    var headers: [String: String] {return [:]}
    var baseHeaders : [String:String] {return defaultHeaders}
    var requestTimeOut: Float {return 30}
    var httpMethod: HTTPMethod {return .GET}
}

extension BaseRequestProtocol {
    var requestURL : String {
        return kBaseURL + path
    }
    
    var defaultHeaders: [String: String] {
        var baseHeaders: [String: String] = [
            KeyParameters.contentTypeKey: KeyParameters.applicationJson,
            KeyParameters.accept: KeyParameters.applicationJson,
            KeyParameters.acceptLanguage: "en-US"
        ]
        // TODO: - To be added when app use User Authorization
//        if let authToken = UserSession.current.credentials.authentication {
//            headers["Authorization"] = authToken
//        }
        baseHeaders += headers
        return headers
    }
    
}


protocol MultipartRequestProtocol: BaseRequestProtocol {
    var attachments: [MultipartAttachment] { get }
}
