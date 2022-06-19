//
//  ApiFetcher.swift
//  

/*
    1- must be check preformance against alamofire (speed/processor/battery)
    2- check multi request diffrent and same result
 
 */

import Foundation
import Combine

protocol Fetcher {
    @discardableResult
    func fetch<ResponseType: Codable > (request: BaseRequestProtocol ,responseClass: ResponseType.Type) -> AnyPublisher<ResponseType,NetworkError>
}


public class APIFetcher: Fetcher {
    func fetch<ResponseType>(request: BaseRequestProtocol, responseClass: ResponseType.Type) -> AnyPublisher<ResponseType, NetworkError> where ResponseType : Decodable, ResponseType : Encodable {
        //SessionConfiguration
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut)
        let decoder = JSONDecoder()
        //Handel URL
        var urlRequest: URLRequest
        if let url =  URL(string: request.requestURL){
            urlRequest = generateUrlRequest(url: url, request: request)
        }else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<ResponseType, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
        debugPrint(urlRequest)
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .validateResponse()
            .responseData()
            .decoding(type: ResponseType.self, decoder: decoder)
            .eraseToAnyPublisher()
        
    }
    
    fileprivate func generateUrlRequest(url: URL, request: BaseRequestProtocol) -> URLRequest {
        var urlRequest: URLRequest
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.baseHeaders
        
        switch request.httpMethod {
        case .GET:
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            if let params = request.parameters, !params.isEmpty {
                urlComponents?.queryItems = params.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
            }
            urlRequest.url = urlComponents?.url ?? url
            
        default:
            if let params = request.parameters?.jsonData {
                urlRequest.httpBody = params
            }
        }
        
        return urlRequest
    }
    
    
    /// Use this to check about internet connection
    static var isConnectedToInternet: Bool {
        return NetworkMonitor.shared.isReachable
    }
}
