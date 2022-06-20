//
//  SearchBar.swift
//  

import SwiftUI
struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    @Binding var placeHolder: String
    var onComit: (() -> Void)?
    
    @State private var showClearButton: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(placeHolder, text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            showClearButton.toggle()
                            searching = true
                        }
                    }
                } onCommit: {
                    if !searchText.isEmpty {
                        onComit?()
                    }
                    withAnimation {
                        searching = false
                        showClearButton.toggle()
                    }
                }
                
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "clear.fill")
                }
                .padding(.horizontal, 6)
                .isHidden(!showClearButton, remove: false)

            }
            .disableAutocorrection(true)
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
    }
}


extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
 }
