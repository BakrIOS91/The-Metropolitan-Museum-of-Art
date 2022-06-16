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
}


extension Baseview {
    @ViewBuilder
    func statusView(viewState: ViewState) -> some View {
        let emptyImage = Image("")
        switch viewState {
        case .loaded:
            AnyView(EmptyView())
        case .loading:
            AnyView(
                LoaderView()
            )
        case .overlayLoading(let overlayColor):
            AnyView(
                LoaderView(viewBackgroundColor: overlayColor)
            )
        case .overlayLoadingWithMessage(let overlayColor,let message):
            AnyView(
                LoaderView(viewBackgroundColor: overlayColor, messageTitle: message)
            )
        case .noData(let description):
            AnyView(
                ErrorView(statusImage: R.image.nodataError()?.suImage ?? emptyImage, statusTitle: R.string.localizable.noDataFound(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            )
            
        case .offline(let description):
            AnyView(
                ErrorView(statusImage: R.image.noNetworkErr()?.suImage ?? emptyImage, statusTitle: R.string.localizable.youAreOffline(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            )
            
        case .serverError(let description):
            AnyView(
                ErrorView(statusImage: R.image.server()?.suImage ?? emptyImage, statusTitle: R.string.localizable.serverError(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            )
            
        case .unexpected(let description):
            AnyView(
                ErrorView(statusImage: R.image.server()?.suImage ?? emptyImage, statusTitle: R.string.localizable.unexpectedError(), statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
            )
            
        case .custom(let icon, let title, let description,let retryable):
            if retryable{
                AnyView(
                    ErrorView(statusImage: icon, statusTitle: title, statusDescription: description,mainButtonTitle: R.string.localizable.retry(), mainButtonAction: fetchData)
                )
            }else{
                AnyView(
                    ErrorView(statusImage: icon, statusTitle: title, statusDescription: description)
                )
            }
        }
    }
}

