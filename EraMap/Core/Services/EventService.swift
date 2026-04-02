//
//  EventService.swift
//  EraMap
//
//  Created by Can Arda on 19.03.26.
//

import Foundation
import Combine
import FirebaseFirestore

class EventService: ObservableObject {
    
    static let shared = EventService()
    
    @Published var events: [HistoricalEvent] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let db = Firestore.firestore()
    private init() {}
    
    // MARK: - Load from Firestore
    func loadEvents() {
        isLoading = true
        
        db.collection("events").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Firestore error: \(error)")
                self.loadFromLocal()
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                print("⚠️ Firestore empty, loading local")
                self.loadFromLocal()
                return
            }
            
            let decoded = documents.compactMap { doc -> HistoricalEvent? in
                let data = doc.data()
                guard
                    let id = data["id"] as? String,
                    let title = data["title"] as? String,
                    let description = data["description"] as? String,
                    let year = data["year"] as? Int,
                    let eraRaw = data["era"] as? String,
                    let era = Era(rawValue: eraRaw),
                    let latitude = data["latitude"] as? Double,
                    let longitude = data["longitude"] as? Double,
                    let significance = data["significance"] as? Int
                else { return nil }
                
                return HistoricalEvent(
                    id: id,
                    title: title,
                    description: description,
                    year: year,
                    era: era,
                    latitude: latitude,
                    longitude: longitude,
                    imageName: data["imageName"] as? String,
                    significance: significance
                )
            }
            
            DispatchQueue.main.async {
                self.events = decoded
                self.isLoading = false
                print("✅ Loaded \(decoded.count) events from Firestore")
            }
        }
    }
    
    // MARK: - Fallback to local JSON
    private func loadFromLocal() {
        guard let url = Bundle.main.url(forResource: "events", withExtension: "json") else {
            print("❌ events.json not found")
            isLoading = false
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([HistoricalEvent].self, from: data)
            DispatchQueue.main.async {
                self.events = decoded
                self.isLoading = false
                print("✅ Loaded \(decoded.count) events from local JSON")
            }
        } catch {
            print("❌ JSON error: \(error)")
            isLoading = false
        }
    }
    
    // MARK: - Seed Firestore from local JSON
    func seedFirestore() {
        guard let url = Bundle.main.url(forResource: "events", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        guard let events = try? JSONDecoder().decode([HistoricalEvent].self, from: data) else { return }
        
        let batch = db.batch()
        
        for event in events {
            let ref = db.collection("events").document(event.id)
            let docData: [String: Any] = [
                "id": event.id,
                "title": event.title,
                "description": event.description,
                "year": event.year,
                "era": event.era.rawValue,
                "latitude": event.latitude,
                "longitude": event.longitude,
                "significance": event.significance,
                "imageName": event.imageName ?? NSNull()
            ]
            batch.setData(docData, forDocument: ref)
        }
        
        batch.commit { error in
            if let error = error {
                print("❌ Seed error: \(error)")
            } else {
                print("✅ Seeded \(events.count) events to Firestore")
            }
        }
    }
    
    // MARK: - Filter helpers
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
