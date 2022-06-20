//
//  HomeViewModel.swift
//  

import Foundation
import Combine

class HomeViewModel: BaseViewModel {
    private var cancellables = Set<AnyCancellable>()

    @Published var viewState: ViewState = .loaded
    @Published var departments : [Department] = []
    @Published var isInistialData: Bool = true
    init(){
        fetchData()
    }
    
    func fetchData(){
        guard self.isConnectedToInternet() else {
            viewState = .offline(description: R.string.localizable.pleaseCheckYourInternetConnections())
            return
        }
        viewState = .loading
        let apiFetcher = APIFetcher()
        let request = DepartmentRequest.getDepartmentsList
        apiFetcher.fetch(request: request, responseClass: DepartmentList.self)
            .sink(receiveCompletion: failureHandle, receiveValue: { [unowned self] depList in
                guard let list = depList.departments, !list.isEmpty else {
                    isInistialData = false
                    return viewState = .noData(description: "")
                }
                departments = list
                isInistialData = false
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
