//
//  SplashView.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("welcome")
                .font(AppFont.mediumWithSize16)
            Text("to")
                .font(AppFont.mediumWithSize14)
            Text("mmoa")
                .font(AppFont.mediumWithSize18)
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                setAppRootView(view: LanguageSelectionVIew())
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            SplashView()
        }
        
    }
}
