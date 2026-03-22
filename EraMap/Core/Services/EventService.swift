//
//  EventService.swift
//  EraMap
//
//  Created by Can Arda on 19.03.26.
//

import Foundation
import Combine

class EventService: ObservableObject {
    
    static let shared = EventService()
    
    @Published var events: [HistoricalEvent] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private init() {}
    
    func loadEvents() {
        isLoading = true
        
        guard let url = Bundle.main.url(forResource: "events", withExtension: "json") else {
            errorMessage = "events.json bulunamadı"
            isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([HistoricalEvent].self, from: data)
            DispatchQueue.main.async {
                self.events = decoded
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "JSON parse hatası: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    func events(for era: Era) -> [HistoricalEvent] {
        events.filter { $0.era == era }
    }
    
    func events(upToYear year: Int, era: Era? = nil) -> [HistoricalEvent] {
        let filtered = events.filter { $0.year <= year }
        if let era = era {
            return filtered.filter { $0.era == era }
        }
        return filtered
    }
}
