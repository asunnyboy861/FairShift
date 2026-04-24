import Foundation

enum TaskFrequency: String, Codable, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly"
    case biWeekly = "Bi-weekly"
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case asNeeded = "As Needed"

    var multiplier: Double {
        switch self {
        case .daily: return 7.0
        case .weekly: return 1.0
        case .biWeekly: return 0.5
        case .monthly: return 0.25
        case .quarterly: return 0.08
        case .asNeeded: return 0.1
        }
    }

    var shortLabel: String {
        switch self {
        case .daily: return "Daily"
        case .weekly: return "Weekly"
        case .biWeekly: return "2 weeks"
        case .monthly: return "Monthly"
        case .quarterly: return "Quarterly"
        case .asNeeded: return "As needed"
        }
    }
}
