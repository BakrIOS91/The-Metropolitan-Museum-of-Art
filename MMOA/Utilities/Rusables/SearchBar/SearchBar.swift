//
//  SearchBar.swift
//  

import SwiftUI
struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    @Binding var placeHolder: String
    var onComit: (() -> Void)?
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.2))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(placeHolder, text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    onComit?()
                    withAnimation {
                        searching = false
                    }
                }
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
