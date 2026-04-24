import Foundation
import SwiftData

@Model
final class TaskCompletion {
    var id: UUID = UUID()
    var completedAt: Date = Date()
    var minutesSpent: Int = 15
    var notes: String = ""
    var photoData: Data?
    var wasInvisible: Bool = false
    var partnerID: UUID = UUID()

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
