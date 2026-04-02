//
//  EraFilterView.swift
//  EraMap
//
//  Created by Can Arda on 26.03.26.
//

import SwiftUI

struct EraFilterView: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(Era.allCases) { era in
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            viewModel.toggleEra(era)
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(era.icon)
                                .font(.system(size: 11))
                            Text(era.displayName)
                                .font(.system(size: 11, weight: .semibold))
                                .lineLimit(1)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            viewModel.isEraActive(era)
                            ? era.color
                            : Color(.systemGray5)
                        )
                        .foregroundColor(
                            viewModel.isEraActive(era) ? .white : .secondary
                        )
                        .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal, 2)
        }
    }
}
