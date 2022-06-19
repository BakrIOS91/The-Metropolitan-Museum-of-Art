//
//  baseRespnse.swift
//  


import Foundation

public protocol BaseResponseProtocol: Codable {
    var status: Int? { get set }
    var totalcount: Int? { get set }
    var message: String? { get set }
    var links_totalcount: Int? {get set}
    var images_totalcount: Int? {get set}
}

class EmptyResponse: BaseResponseProtocol {
    var links_totalcount: Int?
    var images_totalcount: Int?
    var status: Int?
    var message: String?
    var totalcount: Int?
}

class BaseResponse<T: Codable>: BaseResponseProtocol {
    var status: Int?
    var message: String?
    var totalcount: Int?
    var links_totalcount: Int?
    var images_totalcount: Int?
    var result: T?
}

class AppResponse<T: Codable>: BaseResponseProtocol {
    var status: Int?
    var message: String?
    var totalcount: Int?
    var sections_total_count: Int?
    var subsections_total_count: Int?
    var items_total_count: Int?
    var media_total_count: Int?
    var documents_total_count: Int?
    var links_totalcount: Int?
    var images_totalcount: Int?
    var result: T?
}
