//
//  LanguageSelectionView.swift
//  

import SwiftUI

struct LanguageSelectionView: View {
    @Preference(\.locale) var locale
    @Preference(\.rootView) var rootView
    
    var body: some View {
        VStack(spacing: 10){
            Text("pleaseChooseLanguage")
            HStack(spacing: 10){
                ForEach(Locale.appSupported, id: \.self) { locale in
                    Button {
                        updateAppLanguage(locale: locale)
                    } label: {
                        Text("\(locale.languageCode ?? "")".localizedStringKey)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .font(AppFont.mediumWithSize18)
        .padding()
    }
    
    func updateAppLanguage(locale: Locale){
        self.locale = locale
        Bundle.setLanguage(language: locale.languageCode ?? "")
        rootView = .home
    }
}

struct LanguageSelectionVIew_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            LanguageSelectionView()
        }
    }
}
