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
                    EventAnnotationView(event: event, isSelected: viewModel.selectedEvent?.id == event.id)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                viewModel.selectEvent(event)
                            }
                        }
                }
            }
            .ignoresSafeArea()
            
            // MARK: - Alt Panel
            VStack(spacing: 0) {
                
                // Era Filtre Butonları
                EraFilterView(viewModel: viewModel)
                    .padding(.horizontal)
                    .padding(.top, 12)
                
                // Timeline Slider
                TimelineView(viewModel: viewModel)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
            }
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 12)
            .padding(.bottom, 24)
            
            // MARK: - Event Detail Sheet
            if let event = viewModel.selectedEvent {
                EventDetailView(event: event) {
                    withAnimation(.spring()) {
                        viewModel.clearSelection()
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}
