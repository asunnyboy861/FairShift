import Foundation
import SwiftData

@Model
final class TaskCompletion {
    @Attribute(.unique) var id: UUID
    var completedAt: Date
    var minutesSpent: Int
    var notes: String
    var photoData: Data?
    var wasInvisible: Bool
    var partnerID: UUID

    var choreTask: ChoreTask?

    init(partnerID: UUID, minutesSpent: Int = 15, notes: String = "", wasInvisible: Bool = false) {
        self.id = UUID()
        self.completedAt = Date()
        self.minutesSpent = minutesSpent
        self.notes = notes
        self.wasInvisible = wasInvisible
        self.partnerID = partnerID
    }
}
