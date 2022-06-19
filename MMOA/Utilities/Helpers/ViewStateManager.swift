//
//  ViewStateManager.swift
//  

import SwiftUI
enum ViewState: Equatable {
    case loaded
    case loading
    case overlayLoading(overlayColor: Color)
    case overlayLoadingWithMessage(overlayColor: Color, message: String = "")
    case noData(description: String = "")
    case offline(description: String = "")
    case serverError(description: String = "")
    case unexpected(description: String = "")
    case custom(icon: Image, title: String, description: String,retryable: Bool)
}
protocol ViewStateShowingManager {
    var viewState: ViewState { get }
}

