//
//  MainDetailsImage.swift
//  

import SwiftUI

struct ImagePreview: View {
    @ObservedObject var binder = AsyncImageBinder()
    @State var shouldHideLoader: Bool = false
    private var imagePlaceHolder: Image
    
    @State var previewImage: Bool = false
    
    init(imageUrlString: String, placeHolder: Image){
        self.shouldHideLoader = imageUrlString.isEmpty
        self.imagePlaceHolder = placeHolder
        self.binder.load(urlString: imageUrlString)
        
    }
    
    var body: some View {
                if binder.image != nil {
                    renderedImage()
                        .onTapGesture {
                            previewImage.toggle()
                        }
                        .sheet(isPresented: $previewImage) {
                            previewImage = false
                        } content: {
                            renderedImage()
                                .ignoresSafeArea()
                                .pinchToZoom()
                        }
                } else {
                    imagePlaceHolder
                        .renderingMode(.original)
                        .resizable()
                        .overlay {
                            ProgressView()
                                .isHidden(shouldHideLoader, remove: true)

                        }
                }
            

    }
    
    func renderedImage() -> Image {
        Image(uiImage: binder.image!)
            .renderingMode(.original)
            .resizable()
    }
}

//struct MainDetailsImage_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePreview()
//    }
//}
