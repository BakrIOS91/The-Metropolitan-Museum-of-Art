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
            SearchBar(searchText: $searchText, searching: $searching, placeHolder: .constant("Ex. SunFlower")) {
                fetchData()
            }
            List {
                BaseContentView(viewModel.viewState, retryHandler: fetchData, content: {
                    ZStack{
                        VStack {
                            if viewModel.objectList.isEmpty, !viewModel.isInistialData{
                                ErrorView(statusImage: R.image.nodataError()?.suImage ?? Image(""), statusTitle: R.string.localizable.noDataFound(), statusDescription: R.string.localizable.noDataDescription())
                                    .ignoresSafeArea()
                            }else{
                                ScrollView(.vertical){
                                    LazyVGrid(columns: layout, spacing: 20){
                                        ForEach(viewModel.objectList,id: \.self){ id in
                                            NavigationLink {
                                                ObjectDetailsView(objectID: id)
                                            } label: {
                                                Text("\(id)")
                                                    .frame(height: 40)
                                                    .font(AppFont.boldWithSize12)
                                                    .padding()
                                                    .background(Color.blue.opacity(0.4))
                                                    .cornerRadius(5)
                                            }
                                        }
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
