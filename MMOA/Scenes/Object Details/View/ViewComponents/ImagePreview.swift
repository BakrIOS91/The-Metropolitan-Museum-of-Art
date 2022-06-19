//
//  MainDetailsImage.swift
//  

import SwiftUI

struct ImagePreview: View {
    @ObservedObject var binder = AsyncImageBinder()
    @State var shouldHideLoader: Bool = false
    private var imagePlaceHolder: Image
    
    init(imageUrlString: String, placeHolder: Image){
        self.shouldHideLoader = imageUrlString.isEmpty
        self.imagePlaceHolder = placeHolder
        self.binder.load(urlString: imageUrlString)
        
    }
    
    var body: some View {
                if binder.image != nil {
                    NavigationLink {
                        renderedImage()
                    } label: {
                        renderedImage()
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
