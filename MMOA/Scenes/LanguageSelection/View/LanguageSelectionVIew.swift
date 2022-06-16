//
//  LanguageSelectionVIew.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import SwiftUI

struct LanguageSelectionVIew: View {
    
    var body: some View {
        VStack(spacing: 10){
            Text("pleaseChooseLanguage")
                .padding()
            
            HStack(spacing: 10){
                ForEach(Locale.appSupported, id: \.self) { locale in
                    Button {
                        
                    } label: {
                        Text("\(locale.languageCode ?? "")".localizedStringKey)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .font(AppFont.mediumWithSize18)
        .padding()
    }
}

struct LanguageSelectionVIew_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            LanguageSelectionVIew()
        }
    }
}
