//
//  HomeView.swift
// 

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .init()
    @State private var searchText = ""
    
    var body: some View {
        BaseContentView(viewModel.viewState, retryHandler: fetchData, content: {
            NavigationView {
                ZStack{
                    Color.appBackground.ignoresSafeArea()
                    
                    if viewModel.filteredDepartment(name: searchText).isEmpty, !viewModel.isInistialData {
                        ErrorView(statusImage: R.image.nodataError()?.suImage ?? Image(""), statusTitle: R.string.localizable.noDataFound(), statusDescription: R.string.localizable.noDataDescription())
                            .ignoresSafeArea()
                    }else{
                        List {
                            ForEach(viewModel.filteredDepartment(name: searchText),id: \.departmentID){ dep in
                                DepartmentCell(department: dep)
                                    .foregroundColor(.black)
                                    .background(Rectangle().fill(.blue.opacity(0.4)).cornerRadius(10))
                            }
                        }
                        .listStyle(.plain)
                        .refreshable {
                            fetchData()
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle(Text("departments"))
            }
            .navigationViewStyle(.stack)
        })
    }
    
    func fetchData() {
        viewModel.fetchData()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview {
            HomeView()
        }
    }
}
