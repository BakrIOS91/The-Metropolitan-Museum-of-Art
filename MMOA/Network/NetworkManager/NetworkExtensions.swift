//
//  NetworkExtensions.swift
//  ReusableNetworkLayer
//
//  Created by Bakr mohamed on 21/03/2022.
//

import Foundation
import Combine

extension Data {
    mutating func append(_ string: String){
        if let data = string.data(using: .utf8){
            append(data)
        }
    }
    private static let mimeTypeSignatures: [UInt8 : String] = [
        0xFF : "image/jpeg",
        0x89 : "image/png",
        0x25 : "application/pdf",
        0x60 : "image/jpeg",
    ]
    
    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "application/octet-stream"
    }
    
//    var fileExtension: String {
//        switch mimeType {
//        case FileExtension.jpg.rawValue:
//            return "jpg"
//        case FileExtension.png.rawValue:
//            return "png"
//        case FileExtension.pdf.rawValue:
//            return "pdf"
//        case FileExtension.jpeg.rawValue:
//            return "jpeg"
//        default:
//            return "unknown"
//        }
//    }
}

public extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}

public extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    static func +=(lhs: inout Self, rhs: Self) {
        lhs.merge(rhs) { _ , new in new }
    }
    static func +=<S: Sequence>(lhs: inout Self, rhs: S) where S.Element == (Key, Value) {
        lhs.merge(rhs) { _ , new in new }
    }
    
    /// Convert Dictionary to JSON string
    /// - Throws: exception if dictionary cannot be converted to JSON data or when data cannot be converted to UTF8 string
    /// - Returns: JSON string
    func toJson() throws -> String {
        let data = try JSONSerialization.data(withJSONObject: self)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        throw NSError(domain: "Dictionary", code: 1, userInfo: ["message": "Data cannot be converted to .utf8 string"])
    }
}

public extension Publisher where Output == (data: Data, response: URLResponse) {
    func validateResponse() -> AnyPublisher<(data: Data, response: HTTPURLResponse), NetworkError> {
        tryMap { (data: Data, response: URLResponse) in
            guard let http = response as? HTTPURLResponse else { throw NetworkError.nonHTTPResponse }
            return (data, http)
        }
        .mapError { error in
            if error is NetworkError {
                return error as! NetworkError
            } else {
                return NetworkError.serverError(code: 0, error: "Server error")
            }
        }
        .eraseToAnyPublisher()
    }
}

public extension Publisher where Output == (data: Data, response: HTTPURLResponse), Failure == NetworkError {
    func responseData() -> AnyPublisher<Data, NetworkError> {
        tryMap { (data: Data, response: HTTPURLResponse) -> Data in
            switch response.statusCode {
            case 200...299: return data
            case 400...499:
                throw NetworkError.badRequest(code: response.statusCode, error: "Bad Request")
            case 500...599:
                throw NetworkError.serverError(code: response.statusCode, error: "Server Error")
            default:
                fatalError("Unhandled HTTP Response Status code: \(response.statusCode)")
            }
        }
        .mapError { $0 as! NetworkError }
        .eraseToAnyPublisher()
    }
}

public extension Publisher where Output == Data, Failure == NetworkError {
    func decoding<Item, Coder>(type: Item.Type, decoder: Coder) -> AnyPublisher<Item, NetworkError>
    where
        Item: Decodable,
        Coder: TopLevelDecoder,
        Self.Output == Coder.Input
    {
        decode(type: type, decoder: decoder)
            .mapError { error in
                if error is DecodingError {
                    return NetworkError.decodingError(error.localizedDescription)
                } else {
                    return error as! NetworkError
                }
            }
            .eraseToAnyPublisher()
    }
}

