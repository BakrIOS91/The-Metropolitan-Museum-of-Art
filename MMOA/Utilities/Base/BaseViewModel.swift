//
//  BaseViewModel.swift
//  

import Combine

protocol BaseViewModel: ObservableObject, ViewStateShowingManager, InternetConnectionChecker{
    var viewState: ViewState { get set }
}

extension BaseViewModel {
    
    var failureHandle: (Subscribers.Completion<NetworkError>) -> Void  {
        return { [unowned self] comp in
            guard self.isConnectedToInternet() else {
                viewState = .offline(description: R.string.localizable.pleaseCheckYourInternetConnections())
                return
            }
            switch comp {
            case .finished:
                viewState = .loaded
            case .failure(_):
                viewState = .serverError(description: R.string.localizable.pleaseTryAgainLater())
            }
        }
    }
}

protocol InternetConnectionChecker {
    func isConnectedToInternet() -> Bool
}

extension InternetConnectionChecker {
    func isConnectedToInternet() -> Bool {
        return APIFetcher.isConnectedToInternet
    }
}
