//
//  SplashView.swift
//  EraMap
//
//  Created by Can Arda on 03.04.26.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var opacity = 0.0
    @State private var scale = 0.85
    
    var body: some View {
        if isActive {
            MapView()
        } else {
            ZStack {
                Color(hex: "#0D1B2A")
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Image(systemName: "globe.europe.africa.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(hex: "#C9A84C"))
                        .scaleEffect(scale)
                    
                    VStack(spacing: 4) {
                        Text("ERAMAP")
                            .font(.system(size: 32, weight: .bold, design: .serif))
                            .foregroundColor(.white)
                            .tracking(6)
                        
                        Text("HISTORICAL EXPLORER")
                            .font(.system(size: 12, weight: .medium, design: .serif))
                            .foregroundColor(Color(hex: "#C9A84C"))
                            .tracking(4)
                    }
                }
                .opacity(opacity)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    opacity = 1.0
                    scale = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    withAnimation(.easeIn(duration: 0.4)) {
                        isActive = true
                    }
                }
            }
        }
    }
}
