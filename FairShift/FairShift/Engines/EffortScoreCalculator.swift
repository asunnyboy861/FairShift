import Foundation

struct EffortScoreCalculator {
    static let invisibleLoadBonus: Double = 2.5

    static func calculateScore(task: ChoreTask, ownershipRole: OwnershipRole = .fullOwnership) -> Double {
        let baseScore = task.effortWeight.score * task.frequency.multiplier
        let mentalLoadBonus = Double(task.mentalLoadScore) * 0.3
        let invisibleBonus = task.isInvisible ? invisibleLoadBonus : 0

        let ownershipBonus: Double
        switch ownershipRole {
        case .conceptionOnly: ownershipBonus = 3.0
        case .conceptionAndInitiation: ownershipBonus = 4.0
        case .fullOwnership: ownershipBonus = 5.0
        case .executionOnly: ownershipBonus = 1.0
        }

        return baseScore + mentalLoadBonus + invisibleBonus + ownershipBonus
    }

    static func calculateFairness(partner1Total: Double, partner2Total: Double) -> (score: Double, status: BalanceStatus) {
        guard partner1Total + partner2Total > 0 else {
            return (50, .balanced)
        }

        let ratio = min(partner1Total, partner2Total) / max(partner1Total, partner2Total)
        let fairnessScore = ratio * 100
        return (fairnessScore, BalanceStatus.from(score: fairnessScore))
    }

    static func ownershipBreakdown(tasks: [ChoreTask], partner: Partner) -> (conception: Double, initiation: Double, execution: Double) {
        var conceptionScore: Double = 0
        var initiationScore: Double = 0
        var executionScore: Double = 0

        for task in tasks {
            let baseScore = task.effortWeight.score * task.frequency.multiplier

            if task.conceptionOwner?.id == partner.id {
                conceptionScore += baseScore * 0.4
            }
            if task.initiationOwner?.id == partner.id {
                initiationScore += baseScore * 0.3
            }
            if task.executionOwner?.id == partner.id {
                executionScore += baseScore * 0.3
            }
        }

        return (conceptionScore, initiationScore, executionScore)
    }

    static func monthlyEffort(for partner: Partner, tasks: [ChoreTask], completions: [TaskCompletion]) -> Double {
        let partnerCompletions = completions.filter { $0.partnerID == partner.id }
        return partnerCompletions.reduce(0) { total, completion in
            let task = tasks.first { $0.id == completion.choreTask?.id }
            let baseScore = task?.effortWeight.score ?? EffortWeight.medium.score
            let mentalBonus = Double(task?.mentalLoadScore ?? 3) * 0.3
            let invisibleBonus = completion.wasInvisible ? invisibleLoadBonus : 0
            return total + baseScore + mentalBonus + invisibleBonus
        }
    }
}

enum OwnershipRole {
    case conceptionOnly
    case conceptionAndInitiation
    case fullOwnership
    case executionOnly
}
