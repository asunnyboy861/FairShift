import Foundation

enum ChoreCategory: String, Codable, CaseIterable {
    case kitchen = "Kitchen"
    case bathroom = "Bathroom"
    case livingRoom = "Living Room"
    case bedroom = "Bedroom"
    case laundry = "Laundry"
    case grocery = "Groceries"
    case maintenance = "Maintenance"
    case pets = "Pet Care"
    case kids = "Kids"
    case finance = "Finances"
    case social = "Social Planning"
    case health = "Health Management"
    case invisible = "Invisible Load"

    var icon: String {
        switch self {
        case .kitchen: return "fork.knife"
        case .bathroom: return "shower"
        case .livingRoom: return "sofa"
        case .bedroom: return "bed.double"
        case .laundry: return "washer"
        case .grocery: return "cart"
        case .maintenance: return "wrench"
        case .pets: return "pawprint"
        case .kids: return "figure.child"
        case .finance: return "dollarsign"
        case .social: return "person.2"
        case .health: return "heart"
        case .invisible: return "brain"
        }
    }

    var invisibleExamples: [String] {
        switch self {
        case .invisible: return [
            "Remembering to buy toilet paper",
            "Scheduling vet appointments",
            "Noticing the filter needs changing",
            "Planning meals for the week",
            "Remembering birthdays/gifts",
            "Tracking school deadlines",
            "Managing family calendar",
            "Anticipating household needs"
        ]
        default: return []
        }
    }
}
