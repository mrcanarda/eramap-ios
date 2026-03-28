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
            HStack(spacing: 8) {
                ForEach(Era.allCases) { era in
                    Button {
                        withAnimation(.spring()) {
                            viewModel.toggleEra(era)
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(era.icon)
                                .font(.system(size: 13))
                            Text(era.displayName)
                                .font(.system(size: 13, weight: .medium))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
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
        }
    }
}
