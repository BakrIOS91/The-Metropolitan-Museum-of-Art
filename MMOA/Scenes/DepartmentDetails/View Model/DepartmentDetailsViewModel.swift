//
//  DepartmentDetailsViewModel.swift
// 

import Combine

class DepartmentDetailsViewModel: BaseViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var viewState: ViewState = .loaded
    
    @Published var objectList : [Int] = []
    
    func fetchData(departmentID: Int, searchText: String){
        guard self.isConnectedToInternet() else {
            viewState = .offline(description: R.string.localizable.pleaseCheckYourInternetConnections())
            return
        }
        viewState = .overlayLoading(overlayColor: .appBackground)
        let apiFetcher = APIFetcher()
        let request = DepartmentRequest.getDepartmentDetails(id: departmentID, searchText: searchText.isEmpty ? "\"\"" : searchText)
        apiFetcher.fetch(request: request, responseClass: DepartmentDetails.self)
            .sink(receiveCompletion: failureHandle) { [unowned self] details in
                objectList.removeAll()
                if let objIds = details.objectIDs, !objIds.isEmpty {
                    debugPrint(objIds.count)
                    objectList = objIds
                }else{
                    viewState = .noData(description: "")
                }
            }
            .store(in: &cancellables)
        
        
    }
}


