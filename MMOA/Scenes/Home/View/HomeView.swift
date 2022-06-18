//
//  HomeView.swift
//  MMOA
//
//  Created by Bakr mohamed on 17/06/2022.
//

import SwiftUI

struct HomeView: View, Baseview {
    @StateObject var viewModel: HomeViewModel = .init()
    @State private var searchText = ""
    
    var cell: some View {
        Text("Home")
    }
    
    var body: some View {
        BaseContentView(viewModel.viewState, content: {
            NavigationView {
                ZStack{
                    Color.appBackground.ignoresSafeArea()
                    
                    if viewModel.filteredDepartment(name: searchText).isEmpty {
                        ErrorView(statusImage: R.image.nodataError()?.suImage ?? Image(""), statusTitle: R.string.localizable.noDataFound(), statusDescription: R.string.localizable.noDataDescription())
                            .ignoresSafeArea()
                    }else{
                        ScrollView(.vertical){
                            VStack{
                                ForEach(viewModel.filteredDepartment(name: searchText),id: \.departmentID){ dep in
                                    DepartmentCell(title: dep.displayName ?? "")
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.vertical, 10)

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
