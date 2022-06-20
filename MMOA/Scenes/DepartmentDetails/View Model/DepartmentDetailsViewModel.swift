//
//  DepartmentDetailsViewModel.swift
// 

import Combine

class DepartmentDetailsViewModel: BaseViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var viewState: ViewState = .loaded
    
    @Published var objectList : [Int] = []
    @Published var isInistialData: Bool = true
    @Published var canRefresh: Bool = false

    func fetchData(departmentID: Int, searchText: String){
        canRefresh = false
        guard self.isConnectedToInternet() else {
            viewState = .offline(description: R.string.localizable.pleaseCheckYourInternetConnections())
            return
        }
        if !canRefresh {
            viewState = .overlayLoading(overlayColor: .clear)
        }
        
        let apiFetcher = APIFetcher()
        let request = DepartmentRequest.getDepartmentDetails(id: departmentID, searchText: searchText.isEmpty ? "\"\"" : searchText)
        apiFetcher.fetch(request: request, responseClass: DepartmentDetails.self)
            .sink(receiveCompletion: failureHandle) { [unowned self] details in
                objectList.removeAll()
                if let objIds = details.objectIDs, !objIds.isEmpty {
                    debugPrint(objIds.count)
                    objectList = objIds
                    canRefresh = true
                }else{
                    viewState = .noData(description: "")
                }
                isInistialData = false
            }
            .store(in: &cancellables)
        
        
    }
}


