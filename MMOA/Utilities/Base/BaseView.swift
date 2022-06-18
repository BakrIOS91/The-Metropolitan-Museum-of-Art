//
//  Baseview.swift
//  RedBullMobile-iOS
//
//  Created by Bakr mohamed on 17/05/2022.
//

import SwiftUI
import Combine

protocol Baseview{
    var cancellables: Set<AnyCancellable> { get }
    func fetchData()
}


extension Baseview {
    var cancellables: Set<AnyCancellable> {
        return []
    }
    
    func fetchData(){}
}


struct BaseContentView<Content: View>: View, Baseview {
    private var viewState: ViewState
    let content: Content
    
    private let emptyImage = Image("")
    
    init(_ viewState: ViewState, @ViewBuilder content: () -> Content) {
        self.viewState = viewState
        self.content = content()
    }
    
    var body : some View {
        switch viewState {
        case .loaded:
            content
            
        case .loading:
            LoaderView()
                
        case .overlayLoading(let overlayColor):
            LoaderView(viewBackgroundColor: overlayColor)
                
            
        case .overlayLoadingWithMessage(let overlayColor, let message):
            LoaderView(viewBackgroundColor: overlayColor, messageTitle: message)
                
            
        case .noData(let description):
            ErrorView(statusImage: R.image.nodataError()?.suImage ?? emptyImage, statusTitle: R.string.localizable.noDataFound(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            
        case .offline(let description):
            ErrorView(statusImage: R.image.noNetworkErr()?.suImage ?? emptyImage, statusTitle: R.string.localizable.youAreOffline(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            
        case .serverError(let description):
            ErrorView(statusImage: R.image.server()?.suImage ?? emptyImage, statusTitle: R.string.localizable.serverError(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            
        case .unexpected(let description):
            ErrorView(statusImage: R.image.server()?.suImage ?? emptyImage, statusTitle: R.string.localizable.unexpectedError(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            
        case .custom(let icon, let title, let description, let retryable):
            if retryable {
                ErrorView(statusImage: icon, statusTitle: title, statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            } else {
                ErrorView(statusImage: icon, statusTitle: title, statusDescription: description)
            }
            
        }
    }
}
