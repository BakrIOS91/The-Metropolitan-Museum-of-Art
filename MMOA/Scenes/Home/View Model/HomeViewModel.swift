//
//  HomeViewModel.swift
//  MMOA
//
//  Created by Bakr mohamed on 17/06/2022.
//

import Foundation
import Combine

class HomeViewModel: BaseViewModel {
    private var cancellables = Set<AnyCancellable>()

    @Published var viewState: ViewState = .loaded
    
    @Published var departments : [Department] = []
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        guard self.isConnectedToInternet() else {
            viewState = .offline(description: R.string.localizable.pleaseCheckYourInternetConnections())
            return
        }
        viewState = .overlayLoading(overlayColor: .appBackground)
        let apiFetcher = APIFetcher()
        let request = DepartmentRequest.getDepartmentsList
        apiFetcher.fetch(request: request, responseClass: DepartmentList.self)
            .sink(receiveCompletion: failureHandle, receiveValue: { [unowned self] depList in
                guard let list = depList.departments, !list.isEmpty else {
                    return viewState = .noData(description: "")
                }
                departments = list
            })
            .store(in: &cancellables)

    }
    
    
    func filteredDepartment(name: String) -> [Department] {
        if name.isEmpty {
            return departments
        }
        return departments.filter{
            guard let displayName = $0.displayName?.lowercased() else {return false}
            return displayName.contains(name.lowercased())
        }
    }
    
}
