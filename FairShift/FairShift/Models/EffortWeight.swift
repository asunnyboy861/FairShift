import Foundation

enum EffortWeight: String, Codable, CaseIterable {
    case light = "Light"
    case medium = "Medium"
    case heavy = "Heavy"
    case intense = "Intense"

    var score: Double {
        switch self {
        case .light: return 1.0
        case .medium: return 2.5
        case .heavy: return 4.0
        case .intense: return 6.0
        }
    }

    var estimatedRange: String {
        switch self {
        case .light: return "Under 5 min"
        case .medium: return "15-30 min"
        case .heavy: return "30-60 min"
        case .intense: return "1 hour+"
        }
    }
}
