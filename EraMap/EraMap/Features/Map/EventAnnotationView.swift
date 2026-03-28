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
    
    var size: CGFloat {
        switch event.significance {
        case 3: return 18
        case 2: return 14
        default: return 10
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(event.era.color)
                .frame(width: isSelected ? size * 1.6 : size,
                       height: isSelected ? size * 1.6 : size)
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: isSelected ? 2.5 : 1.5)
                )
                .shadow(color: event.era.color.opacity(0.5), radius: isSelected ? 8 : 3)
            
            if isSelected {
                Text(event.era.icon)
                    .font(.system(size:10))
            }
        }
        .animation(.spring(), value: isSelected)
    }
}
