//
//  NetworkConstants.swift
//  ReusableNetworkLayer
//
//  Created by Bakr mohamed on 21/03/2022.
//

import Foundation

let kApiKey = "c66b1ca9a2f132321af246e72180f14d"

let kAppEnvironment: AppEnvironment = .development

// MARK: - kBaseURLComponents
var kBaseURLComponents: URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = kScheme
    urlComponents.host = kHost
    if kPort != nil {
        urlComponents.port = kPort
    }
    return urlComponents
}

// MARK: - kBaseURL
var kBaseURL: String {
    return kBaseURLComponents.url?.absoluteString ?? ""
}

// MARK: - kScheme
var kScheme: String {
    switch kAppEnvironment {
    case .development:  return "https"
    case .staging:      return "http"
    case .testing:      return "http"
    case .live:         return "https"
    }
}

// MARK: - kHost
var kHost: String {
    switch kAppEnvironment {
    case .development:  return "api.openweathermap.org"
    case .staging:      return ""
    case .testing:      return ""
    case .live:         return ""
    }
}

// MARK: - kPort
var kPort: Int? {
    switch kAppEnvironment {
    case .development:  return nil
    case .staging:      return nil
    case .testing:      return nil
    case .live:         return nil
    }
}


// MARK: - all requests key parameters
struct KeyParameters {
    static var contentTypeKey = "Content-Type"
    static var accept = "Accept"
    static var applicationJson = "application/json"
    static var authorization = "Authorization"
    static var acceptLanguage = "Accept-Language"
    
}
