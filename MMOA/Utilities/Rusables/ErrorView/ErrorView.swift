//
//  ErrorView.swift
//  

import SwiftUI

struct ErrorView: View {
    var viewBackgroundColor: Color = .appBackground
    var statusImage: Image
    var statusTitle: String
    var statusDescription: String
    var mainButtonTitle: String? = nil
    var mainButtonBackgroundColor = Color.appMainBlue
    var mainButtonAction: (() -> Void)? = nil
    
    var secondaryButtonTitle: String? = nil
    var secondaryButtonBackgroundColor = Color.clear
    var secondaryButtonAction: (() -> Void)? = nil
    
    var defaultSecondaryButtonWidth = UIScreen.main.bounds.width / 4
    
    
    var body: some View {
        ZStack {
            viewBackgroundColor.ignoresSafeArea()
            
            VStack(alignment: .center){
                statusImage
                    .frame(width: 150, height: 150, alignment: .center)
                    .aspectRatio(contentMode: .fill)
                    .padding(.bottom, 30)
                
                Text(statusTitle)
                    .font(AppFont.boldWithSize16)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 14)
                    .isHidden(statusTitle.isEmpty, remove: true)

                
                
                Text(statusDescription)
                    .font(AppFont.regularWithSize14)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding([.leading,.trailing], 30)
                    .padding(.bottom, 31)
                    .isHidden(statusDescription.isEmpty, remove: true)

                
                HStack(spacing: 5) {
                    Button {
                        secondaryButtonAction?()
                    } label: {
                        Text(secondaryButtonTitle ?? "")
                    }
                    .font(AppFont.regularWithSize16)
                    .frame(maxWidth: defaultSecondaryButtonWidth, maxHeight: .infinity)
                    .foregroundColor(.black)
                    .background(secondaryButtonBackgroundColor)
                    .isHidden(!(secondaryButtonTitle != nil && secondaryButtonTitle?.isEmpty == false), remove: true)
                    
                    Button {
                        mainButtonAction?()
                    } label: {
                        Text(mainButtonTitle ?? "")
                    }
                    .font(AppFont.boldWithSize16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .background(mainButtonBackgroundColor)
                    .cornerRadius(27)
                    .isHidden(!(mainButtonTitle != nil && mainButtonTitle?.isEmpty == false), remove: true)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 53)
                .padding([.leading,.trailing], 30)
                
                
            }
        }
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview {
            ErrorView(statusImage: R.image.server()?.suImage ?? Image(""), statusTitle: R.string.localizable.serverError(), statusDescription: "description",mainButtonTitle: R.string.localizable.retry(), mainButtonAction: {})
        }
    }
}
