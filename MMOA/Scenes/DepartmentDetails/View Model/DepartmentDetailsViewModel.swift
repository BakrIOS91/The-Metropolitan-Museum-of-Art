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
    @Published var hideLoadMore: Bool = true
    
    private var chunkecdArr: [[Int]] = []
    private var index : Int = 0
    

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
        let request = DepartmentRequest.getDepartmentDetails(id: departmentID, searchText: searchText)
        apiFetcher.fetch(request: request, responseClass: DepartmentDetails.self)
            .sink(receiveCompletion: failureHandle) { [unowned self] details in
                objectList.removeAll()
                index = 0
                if let objIds = details.objectIDs, !objIds.isEmpty {
                    chunkecdArr = objIds.chunked(into: 50)
                    hideLoadMore = chunkecdArr.count == 1
                    objectList = chunkecdArr[0]
                    canRefresh = true
                }else{
                    viewState = .noData(description: "")
                }
                isInistialData = false
            }
            .store(in: &cancellables)
    }
    
    func loadMore(){
        index += 1
        if index < chunkecdArr.count - 1 {
            objectList.append(contentsOf: chunkecdArr[index])
        }else{
            hideLoadMore = true
        }
    }
}



