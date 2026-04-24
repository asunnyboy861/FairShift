import SwiftUI
import SwiftData

@Observable
final class BalanceViewModel {
    var fairnessScore: Double = 50
    var balanceStatus: BalanceStatus = .balanced
    var partner1Breakdown: (conception: Double, initiation: Double, execution: Double) = (0, 0, 0)
    var partner2Breakdown: (conception: Double, initiation: Double, execution: Double) = (0, 0, 0)
    var insights: [PatternRadarAnalyzer.Insight] = []

    func loadBalanceData(modelContext: ModelContext, partners: [Partner]) {
        let descriptor = FetchDescriptor<ChoreTask>()

        do {
            let tasks = try modelContext.fetch(descriptor)

            if partners.count >= 2 {
                let p1Total = EffortScoreCalculator.monthlyEffort(for: partners[0], tasks: tasks, completions: fetchCompletions(modelContext: modelContext))
                let p2Total = EffortScoreCalculator.monthlyEffort(for: partners[1], tasks: tasks, completions: fetchCompletions(modelContext: modelContext))

                let result = EffortScoreCalculator.calculateFairness(partner1Total: p1Total, partner2Total: p2Total)
                fairnessScore = result.score
                balanceStatus = result.status

                partner1Breakdown = EffortScoreCalculator.ownershipBreakdown(tasks: tasks, partner: partners[0])
                partner2Breakdown = EffortScoreCalculator.ownershipBreakdown(tasks: tasks, partner: partners[1])

                insights = PatternRadarAnalyzer.generateInsights(tasks: tasks, partners: partners)
            }
        } catch {
            print("Failed to load balance data: \(error)")
        }
    }

    private func fetchCompletions(modelContext: ModelContext) -> [TaskCompletion] {
        let descriptor = FetchDescriptor<TaskCompletion>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
}
