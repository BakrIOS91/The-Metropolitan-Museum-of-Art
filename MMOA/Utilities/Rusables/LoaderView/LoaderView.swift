//
//  LoaderView.swift
//  

import SwiftUI

struct LoaderView: View {
    @State private var isAnimating: Bool = false
    var viewBackgroundColor: Color = .clear
    var loaderColor: Color = .appMainBlue
    
    // for the Text under the loader
    var messageTitle: String = ""
    var messageTitleColor: Color = .black
    
    var body: some View {
        ZStack {
            viewBackgroundColor.ignoresSafeArea()
            
            VStack {
                GeometryReader { (geometry: GeometryProxy) in
                    ForEach(0..<5) { index in
                        Group {
                            Circle()
                                .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                                .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
                                .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .foregroundColor(loaderColor)
                        .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                        .animation(Animation
                            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                            .repeatForever(autoreverses: false), value: isAnimating)
                    }
                }
                .frame(width: 70, height: 70, alignment: .center)
                .aspectRatio(1, contentMode: .fit)
                
                Text(messageTitle)
                    .padding(20)
                    .foregroundColor(messageTitleColor)
                    .multilineTextAlignment(.center)
                    .font(AppFont.mediumWithSize14)
                    .isHidden(messageTitle.isEmpty, remove: true)
            }
            .onAppear {
                isAnimating.toggle()
            }
            .onDisappear {
                isAnimating.toggle()
            }
        }
    }
    
}
