import SwiftUI
import SwiftData

@Observable
final class TodayViewModel {
    var todayTasks: [ChoreTask] = []
    var completedToday: [TaskCompletion] = []
    var partner1TodayScore: Double = 0
    var partner2TodayScore: Double = 0
    var showingCompletionSheet = false
    var selectedTask: ChoreTask?

    func loadTodayData(modelContext: ModelContext, partners: [Partner]) {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())

        let taskDescriptor = FetchDescriptor<ChoreTask>(sortBy: [SortDescriptor(\.title)])
        let completionDescriptor = FetchDescriptor<TaskCompletion>(
            predicate: #Predicate { $0.completedAt >= todayStart },
            sortBy: [SortDescriptor(\.completedAt, order: .reverse)]
        )

        do {
            todayTasks = try modelContext.fetch(taskDescriptor)
            completedToday = try modelContext.fetch(completionDescriptor)

            if partners.count >= 2 {
                partner1TodayScore = EffortScoreCalculator.monthlyEffort(for: partners[0], tasks: todayTasks, completions: completedToday)
                partner2TodayScore = EffortScoreCalculator.monthlyEffort(for: partners[1], tasks: todayTasks, completions: completedToday)
            }
        } catch {
            print("Failed to fetch today data: \(error)")
        }
    }

    func completeTask(_ task: ChoreTask, partner: Partner, minutesSpent: Int, notes: String, modelContext: ModelContext) {
        let completion = TaskCompletion(partnerID: partner.id, minutesSpent: minutesSpent, notes: notes, wasInvisible: task.isInvisible)
        completion.choreTask = task
        task.lastCompletedAt = Date()
        modelContext.insert(completion)
        try? modelContext.save()
    }

    func tasksForPartner(_ partner: Partner) -> [ChoreTask] {
        todayTasks.filter { $0.executionOwner?.id == partner.id }
    }

    func isTaskCompletedToday(_ task: ChoreTask) -> Bool {
        guard let lastCompleted = task.lastCompletedAt else { return false }
        return Calendar.current.isDateInToday(lastCompleted)
    }
}
