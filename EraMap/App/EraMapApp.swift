//
//  EraMapApp.swift
//  EraMap
//
//  Created by Can Arda on 19.03.26.
//

import SwiftUI
import FirebaseCore

@main
struct EraMapApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
