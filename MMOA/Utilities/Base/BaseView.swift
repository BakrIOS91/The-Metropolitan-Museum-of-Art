//
//  Baseview.swift
//  RedBullMobile-iOS
//
//  Created by Bakr mohamed on 17/05/2022.
//

import SwiftUI

struct BaseContentView<Content: View>: View {
    private var viewState: ViewState
    let content: Content
    var retryHandler: () -> Void
    
    private let emptyImage = Image("")
    
    init(_ viewState: ViewState, retryHandler: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.viewState = viewState
        self.content = content()
        self.retryHandler = retryHandler
    }
    
    var body : some View {
        switch viewState {
        case .loaded:
            content
            
        case .loading:
            ZStack{
                content
                LoaderView()
            }
                
        case .overlayLoading(let overlayColor):
            LoaderView(viewBackgroundColor: overlayColor)
                
            
        case .overlayLoadingWithMessage(let overlayColor, let message):
            LoaderView(viewBackgroundColor: overlayColor, messageTitle: message)
                
            
        case .noData(let description):
            ErrorView(statusImage: R.image.nodataError()?.suImage ?? emptyImage, statusTitle: R.string.localizable.noDataFound(), statusDescription: description)
            
        case .offline(let description):
            ErrorView(statusImage: R.image.noNetworkErr()?.suImage ?? emptyImage, statusTitle: R.string.localizable.youAreOffline(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: retryHandler)
            
        case .serverError(let description):
            ErrorView(statusImage: R.image.server()?.suImage ?? emptyImage, statusTitle: R.string.localizable.serverError(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: retryHandler)
            
        case .unexpected(let description):
            ErrorView(statusImage: R.image.server()?.suImage ?? emptyImage, statusTitle: R.string.localizable.unexpectedError(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: retryHandler)
            
        case .custom(let icon, let title, let description, let retryable):
            if retryable {
                ErrorView(statusImage: icon, statusTitle: title, statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: retryHandler)
            } else {
                ErrorView(statusImage: icon, statusTitle: title, statusDescription: description)
            }
            
        }
    }
}
