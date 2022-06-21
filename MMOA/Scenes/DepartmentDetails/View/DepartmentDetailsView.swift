//
//  DepartmentDetailsView.swift
//  

import SwiftUI

struct DepartmentDetailsView: View {
    @StateObject var viewModel: DepartmentDetailsViewModel = .init()
    @State private var onApearCalled: Bool = false
    @State private var searchText = ""
    @State var searching = false
    
    var departmentId: Int
    
    private let layout = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, searching: $searching, placeHolder: .constant(R.string.localizable.searchPlaceHolder())) {
                fetchData()
            }
            List {
                BaseContentView(viewModel.viewState, retryHandler: fetchData, content: {
                    ZStack{
                        VStack {
                            if viewModel.isInistialData{
                                Text("screenMessage")
                                    .font(AppFont.regularWithSize14)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.gray)
                                
                            }else if viewModel.objectList.isEmpty{
                                ErrorView(statusImage: R.image.nodataError()?.suImage ?? Image(""), statusTitle: R.string.localizable.noDataFound(), statusDescription: R.string.localizable.noDataDescription())
                                    .ignoresSafeArea()
                            }else{
                                ScrollView(.vertical){
                                    VStack(spacing: 20) {
                                        LazyVGrid(columns: layout, spacing: 20){
                                            ForEach(viewModel.objectList,id: \.self){ id in
                                                NavigationLink {
                                                    ObjectDetailsView(objectID: id)
                                                } label: {
                                                    Text("\(id)")
                                                        .frame(width: 50,height: 50)
                                                        .font(AppFont.boldWithSize12)
                                                        .padding()
                                                        .background(Color.blue.opacity(0.4))
                                                        .cornerRadius(5)
                                                }
                                            }
                                        }
                                        
                                        Button {
                                            viewModel.loadMore()
                                        } label: {
                                            Text("loadMore")
                                        }
                                        .font(AppFont.regularWithSize12)
                                        .isHidden(viewModel.hideLoadMore, remove: false)
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                })
                .listRowInsets(.none)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .ignoresSafeArea(.all)
            }
            .listStyle(.plain)
            .if(viewModel.canRefresh){ view in
                view.refreshable {
                    fetchData()
                }
            }
            .padding(.vertical, 10)
            .navigationTitle(Text("departmentDetails"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func fetchData() {
        viewModel.fetchData(departmentID: departmentId, searchText: searchText)
        
    }
}

struct DepartmentDetails_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            DepartmentDetailsView(departmentId: 1)
        }
    }
}
