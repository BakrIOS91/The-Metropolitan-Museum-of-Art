//
//  LanguageSelectionVIew.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import SwiftUI

struct LanguageSelectionVIew: View {
    @Preference(\.locale) var locale
    
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
    }
}

struct LanguageSelectionVIew_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            LanguageSelectionVIew()
        }
    }
}
