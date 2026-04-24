import Foundation

enum BalanceStatus: String, Codable {
    case balanced = "Balanced"
    case slightlyOff = "Slightly Off"
    case needsAttention = "Needs Attention"
    case unbalanced = "Unbalanced"

    var color: String {
        switch self {
        case .balanced: return "SageGreen"
        case .slightlyOff: return "Amber"
        case .needsAttention: return "PartnerCoral"
        case .unbalanced: return "Rose"
        }
    }

    var emoji: String {
        switch self {
        case .balanced: return "✅"
        case .slightlyOff: return "🟡"
        case .needsAttention: return "🟠"
        case .unbalanced: return "🔴"
        }
    }

    var description: String {
        switch self {
        case .balanced: return "Great balance! You and your partner share the load fairly."
        case .slightlyOff: return "Close to balanced. A few small shifts could help."
        case .needsAttention: return "One partner carries significantly more. Time to rebalance."
        case .unbalanced: return "Major imbalance detected. Let's work on redistributing tasks."
        }
    }

    static func from(score: Double) -> BalanceStatus {
        switch score {
        case 85...100: return .balanced
        case 70..<85: return .slightlyOff
        case 50..<70: return .needsAttention
        default: return .unbalanced
        }
    }
}
