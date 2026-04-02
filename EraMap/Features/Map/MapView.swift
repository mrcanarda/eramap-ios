//
//  MapView.swift
//  EraMap
//
//  Created by Can Arda on 19.03.26.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // MARK: - Map
            Map(coordinateRegion: $viewModel.region,
                annotationItems: viewModel.visibleEvents) { event in
                MapAnnotation(coordinate: event.coordinate) {
                    EventAnnotationView(
                        event: event,
                        isSelected: viewModel.selectedEvent?.id == event.id
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4)) {
                            viewModel.selectEvent(event)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            // MARK: - Bottom Panel
            VStack(spacing: 0) {
                if let event = viewModel.selectedEvent {
                    EventDetailView(event: event) {
                        withAnimation(.spring(response: 0.4)) {
                            viewModel.clearSelection()
                        }
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                } else {
                    VStack(spacing: 12) {
                        EraFilterView(viewModel: viewModel)
                        TimelineView(viewModel: viewModel)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 14)
                    .padding(.bottom, 34)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
