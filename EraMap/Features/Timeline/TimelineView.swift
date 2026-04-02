//
//  TimelineView.swift
//  EraMap
//
//  Created by Can Arda on 26.03.26.
//

import SwiftUI

struct TimelineView: View {
    @ObservedObject var viewModel: MapViewModel
    
    var displayYear: String {
        viewModel.currentYear < 0
        ? "\(abs(viewModel.currentYear)) BC"
        : "AD \(viewModel.currentYear)"
    }
    
    var sliderValue: Binding<Double> {
        Binding(
            get: { Double(viewModel.currentYear) },
            set: { viewModel.setYear(Int($0)) }
        )
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(displayYear)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .frame(minWidth: 80, alignment: .leading)
                
                Spacer()
                
                Text("\(viewModel.visibleEvents.count) events")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                
                Button {
                    viewModel.togglePlayback()
                } label: {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            
            Slider(
                value: sliderValue,
                in: Double(viewModel.globalYearRange.lowerBound)...Double(viewModel.globalYearRange.upperBound),
                step: 1
            )
            .tint(.primary)
        }
    }
}
