//
//  MapViewModel.swift
//  EraMap
//
//  Created by Can Arda on 19.03.26.
//

import Foundation
import MapKit
import Combine

class MapViewModel: ObservableObject {
    
    @Published var visibleEvents: [HistoricalEvent] = []
    @Published var selectedEvent: HistoricalEvent? = nil
    @Published var activeEras: Set<Era> = Set(Era.allCases)
    @Published var currentYear: Int = 1000
    @Published var isPlaying: Bool = false
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 45.0, longitude: 15.0),
        span: MKCoordinateSpan(latitudeDelta: 60.0, longitudeDelta: 60.0)
    )
    
    private let eventService = EventService.shared
    private var cancellables = Set<AnyCancellable>()
    private var playTimer: Timer?
    
    var globalYearRange: ClosedRange<Int> { -753...1945 }
    
    init() {
        eventService.loadEvents()
        
        Publishers.CombineLatest3(
            eventService.$events,
            $currentYear,
            $activeEras
        )
        .map { events, year, eras in
            events.filter { $0.year <= year && eras.contains($0.era) }
        }
        .receive(on: DispatchQueue.main)
        .assign(to: &$visibleEvents)
    }
    
    // MARK: - Era Filter
    func toggleEra(_ era: Era) {
        if activeEras.contains(era) {
            activeEras.remove(era)
        } else {
            activeEras.insert(era)
        }
    }
    
    func isEraActive(_ era: Era) -> Bool {
        activeEras.contains(era)
    }
    
    // MARK: - Timeline
    func setYear(_ year: Int) {
        currentYear = year
    }
    
    func startPlayback() {
        isPlaying = true
        playTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.currentYear >= self.globalYearRange.upperBound {
                self.stopPlayback()
            } else {
                self.currentYear += 5
            }
        }
    }
    
    func stopPlayback() {
        isPlaying = false
        playTimer?.invalidate()
        playTimer = nil
    }
    
    func togglePlayback() {
        isPlaying ? stopPlayback() : startPlayback()
    }
    
    // MARK: - Event Selection
    func selectEvent(_ event: HistoricalEvent) {
        selectedEvent = event
    }
    
    func clearSelection() {
        selectedEvent = nil
    }
}
