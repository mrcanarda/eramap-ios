//
//  Era.swift
//  EraMap
//
//  Created by Can Arda on 19.03.26.
//

import SwiftUI

enum Era: String, CaseIterable, Codable, Identifiable {
    case viking = "viking"
    case ottoman = "ottoman"
    case wwii = "wwii"
    case rome = "rome"
    
    var id: String {rawValue}
    
    var displayName: String {
        switch self {
        case .viking: return "Vikings"
        case .ottoman: return "Ottoman Empire"
        case .wwii: return "World War II"
        case .rome: return "Roman Empire"
        }
    }
    
    var yearRange: ClosedRange<Int> {
        switch self {
        case .viking: return 793...1066
        case .ottoman: return 1299...1683
        case .wwii: return 1939...1945
        case .rome: return -753...476
        }
    }
    
    var color: Color {
        switch self {
        case .viking:  return Color("EraViking")
        case .ottoman: return Color("EraOttoman")
        case .wwii:    return Color("EraWWII")
        case .rome:    return Color("EraRome")
        }
    }
    
    var icon: String {
           switch self {
           case .viking:  return "⚔️"
           case .ottoman: return "🌙"
           case .wwii:    return "💀"
           case .rome:    return "🏛️"
           }
       }
}
