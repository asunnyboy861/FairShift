import Foundation

enum OwnershipType: String, Codable {
    case fullOwnership = "Full Ownership"
    case sharedOwnership = "Shared Ownership"
    case delegatedExecution = "Delegated"

    var shortDescription: String {
        switch self {
        case .fullOwnership: return "Think, start, and do it. No reminding needed."
        case .sharedOwnership: return "Both share the mental load. Coordinate together."
        case .delegatedExecution: return "One plans, the other executes."
        }
    }

    var conceptionWeight: Double {
        switch self {
        case .fullOwnership: return 0.4
        case .sharedOwnership: return 0.2
        case .delegatedExecution: return 0.4
        }
    }

    var initiationWeight: Double {
        switch self {
        case .fullOwnership: return 0.3
        case .sharedOwnership: return 0.15
        case .delegatedExecution: return 0.3
        }
    }

    var executionWeight: Double {
        switch self {
        case .fullOwnership: return 0.3
        case .sharedOwnership: return 0.15
        case .delegatedExecution: return 0.3
        }
    }
}
