//
//  EventAnnotationView.swift
//  EraMap
//
//  Created by Can Arda on 26.03.26.
//

import SwiftUI

struct EventAnnotationView: View {
    let event: HistoricalEvent
    let isSelected: Bool
    
    @State private var isPulsing = false
    
    var size: CGFloat {
        switch event.significance {
        case 3: return 18
        case 2: return 14
        default: return 10
        }
    }
    
    var body: some View {
        ZStack {
            // Pulse ring
            if isSelected {
                Circle()
                    .fill(event.era.color.opacity(0.3))
                    .frame(width: size * 3, height: size * 3)
                    .scaleEffect(isPulsing ? 1.4 : 1.0)
                    .opacity(isPulsing ? 0 : 0.6)
                    .animation(
                        .easeOut(duration: 1.2).repeatForever(autoreverses: false),
                        value: isPulsing
                    )
            }
            
            // Outer glow
            Circle()
                .fill(event.era.color.opacity(0.25))
                .frame(width: isSelected ? size * 2.2 : size * 1.6,
                       height: isSelected ? size * 2.2 : size * 1.6)
            
            // Main dot
            Circle()
                .fill(event.era.color)
                .frame(width: isSelected ? size * 1.5 : size,
                       height: isSelected ? size * 1.5 : size)
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: isSelected ? 2.5 : 1.5)
                )
            
            if isSelected {
                Text(event.era.icon)
                    .font(.system(size: size * 0.7))
            }
        }
        .animation(.spring(response: 0.4), value: isSelected)
        .onAppear {
            isPulsing = true
        }
        .onChange(of: isSelected) { _ in
            isPulsing = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPulsing = true
            }
        }
    }
}
