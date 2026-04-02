//
//  Era.swift
//  EraMap
//
//  Created by Can Arda on 19.03.26.
//

import SwiftUI

enum Era: String, CaseIterable, Codable, Identifiable {
    case viking   = "viking"
    case ottoman  = "ottoman"
    case wwii     = "wwii"
    case rome     = "rome"
    case turkish  = "turkish"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .viking:  return "Vikings"
        case .ottoman: return "Ottoman Empire"
        case .wwii:    return "World War II"
        case .rome:    return "Roman Empire"
        case .turkish: return "WWI & Turkish Independence"
        }
    }

    var yearRange: ClosedRange<Int> {
        switch self {
        case .viking:  return 793...1066
        case .ottoman: return 1299...1683
        case .wwii:    return 1939...1945
        case .rome:    return -753...476
        case .turkish: return 1914...1938
        }
    }

    var color: Color {
        switch self {
        case .viking:  return Color("EraViking")
        case .ottoman: return Color("EraOttoman")
        case .wwii:    return Color("EraWWII")
        case .rome:    return Color("EraRome")
        case .turkish: return Color("EraTurkish")
        }
    }

    var icon: String {
        switch self {
        case .viking:  return "⚔️"
        case .ottoman: return "🌙"
        case .wwii:    return "💀"
        case .rome:    return "🏛️"
        case .turkish: return "🌙⭐"
        }
    }
}
