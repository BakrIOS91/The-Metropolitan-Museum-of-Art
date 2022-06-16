//
//  BaseViewModel.swift
//  RedBullMobile-iOS
//
//  Created by Bakr mohamed on 17/05/2022.
//

import Foundation

protocol BaseViewModel: ObservableObject, ViewStateShowingManager, InternetConnectionChecker{}

protocol InternetConnectionChecker {
    func isConnectedToInternet() -> Bool
}

extension InternetConnectionChecker {
    func isConnectedToInternet() -> Bool {
        return APIFetcher.isConnectedToInternet
    }
}
