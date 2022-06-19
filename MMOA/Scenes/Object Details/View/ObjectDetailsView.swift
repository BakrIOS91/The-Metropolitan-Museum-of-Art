//
//  ObjectDetailsView.swift
//

import SwiftUI

struct ObjectDetailsView: View {
    @StateObject var viewModel: objectDetailsViewModel = .init()
    @State private var onApearCalled: Bool = false
    var objectID: Int
    
    
    var body: some View {
        BaseContentView(viewModel.viewState, retryHandler: fetchData, content: {
            GeometryReader { geo in
                VStack(spacing: 5){
                    ImagePreview(imageUrlString: viewModel.primaryImage, placeHolder: Image("imagePlaceholder"))
                        .frame(width: geo.size.width - 10, height: geo.size.height * 0.7, alignment: .center)
                        .padding(5)
                    
                    ScrollView(.horizontal) {
                        LazyHStack{
                            ForEach(viewModel.gallery, id:\.self){ urlString in
                                ImagePreview(imageUrlString: urlString, placeHolder: Image("imagePlaceholder"))
                                    .frame(width: geo.size.height * 0.25, height: geo.size.height * 0.25, alignment: .center)
                                
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                }
            }
        })
        .navigationTitle(Text("\(objectID)"))
        .toolbar {
            Menu {
                Text(R.string.localizable.obj_Name(viewModel.ObjectName.replaceEmpty()))
                Text(R.string.localizable.obj_Department(viewModel.deprtment.replaceEmpty()))
                Text(R.string.localizable.obj_Artist(viewModel.artistDisplayName.replaceEmpty()))
                Text(R.string.localizable.obj_City(viewModel.state.replaceEmpty()))
            } label: {
                Image(systemName: "info.circle")
            }
            .menuStyle(DefaultMenuStyle())

            
        }
        .onAppear {
            if !onApearCalled {
                fetchData()
                onApearCalled.toggle()
            }
        }
        
    }
    
    func fetchData(){
        viewModel.fetchObjectDetails(objectId: objectID)
    }
}

struct ObjectDetails_Previews: PreviewProvider {
    static var previews: some View {
        ObjectDetailsView(objectID: 1)
    }
}
