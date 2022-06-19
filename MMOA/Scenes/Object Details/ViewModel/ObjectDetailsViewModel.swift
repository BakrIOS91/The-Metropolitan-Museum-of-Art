//
//  ObjectDetailsViewModel.swift
//  MMOA
//
//  Created by Bakr mohamed on 19/06/2022.
//

import Combine

class objectDetailsViewModel: BaseViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var viewState: ViewState = .loaded
    
    @Published var ObjectName: String = ""
    @Published var primaryImage: String = ""
    @Published var gallery: [String] = []
    @Published var deprtment: String = ""
    @Published var artistDisplayName: String = ""
    @Published var state: String = ""
    
    
    
    func fetchObjectDetails(objectId: Int){
        guard self.isConnectedToInternet() else {
            viewState = .offline(description: R.string.localizable.pleaseCheckYourInternetConnections())
            return
        }
        viewState = .overlayLoading(overlayColor: .appBackground)
        let apiFetcher = APIFetcher()
        let request = DepartmentRequest.getObjectDetails(id: objectId)
        apiFetcher.fetch(request: request, responseClass: ObjectDetails?.self)
            .sink(receiveCompletion: failureHandle) { [unowned self] details in
                if let details = details {
                    debugPrint(details)
                    ObjectName = details.objectName ?? ""
                    primaryImage = details.primaryImage ?? ""
                    gallery = details.additionalImages ?? []
                    deprtment = details.department ?? ""
                    artistDisplayName = details.artistDisplayName ?? ""
                    state = details.city ?? ""
                }else{
                    viewState = .noData(description: "")
                }
            }
            .store(in: &cancellables)
    }
    
    
}
