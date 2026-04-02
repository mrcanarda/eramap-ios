//
//  EventDetailView.swift
//  EraMap
//
//  Created by Can Arda on 26.03.26.
//

import SwiftUI

struct EventDetailView: View {
    let event: HistoricalEvent
    let onClose: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(event.era.icon)
                            .font(.system(size: 14))
                        Text(event.era.displayName)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(event.era.color)
                        Text("·")
                            .foregroundColor(.secondary)
                        Text(event.displayYear)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                    
                    Text(event.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.secondary)
                        .frame(width: 28, height: 28)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 14)
            
            Divider()
                .padding(.horizontal, 20)
            
            // MARK: - Description
            Text(event.description)
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .lineSpacing(4)
                .padding(20)
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.12), radius: 20, x: 0, y: -4)
        .padding(.horizontal, 12)
        .padding(.bottom, 34)
    }
}
