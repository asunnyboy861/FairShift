import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Partner.createdAt) private var partners: [Partner]
    @State private var viewModel = TodayViewModel()
    @State private var showingAddTask = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if partners.count >= 2 {
                        todaySummary
                        partnerTaskLists
                    } else {
                        EmptyStateView(
                            icon: "person.2.badge.plus",
                            title: "Add Your Partner",
                            subtitle: "Set up both partners to start tracking your household balance"
                        )
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(partners: partners)
            }
            .onAppear {
                viewModel.loadTodayData(modelContext: modelContext, partners: partners)
            }
        }
    }

    private var todaySummary: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Today's Balance")
                    .font(.headline)

                Spacer()

                BalanceGauge(score: fairnessScore, size: 60)
            }

            HStack(spacing: 16) {
                PartnerScoreCard(partner: partners[0], score: viewModel.partner1TodayScore)
                PartnerScoreCard(partner: partners[1], score: viewModel.partner2TodayScore)
            }
        }
        .padding()
        .cardStyle()
    }

    private var fairnessScore: Double {
        let result = EffortScoreCalculator.calculateFairness(
            partner1Total: viewModel.partner1TodayScore,
            partner2Total: viewModel.partner2TodayScore
        )
        return result.score
    }

    private var partnerTaskLists: some View {
        VStack(spacing: 16) {
            ForEach(partners) { partner in
                PartnerTaskSection(
                    partner: partner,
                    tasks: viewModel.tasksForPartner(partner),
                    isCompleted: { viewModel.isTaskCompletedToday($0) },
                    onComplete: { task in
                        viewModel.selectedTask = task
                        viewModel.showingCompletionSheet = true
                    }
                )
            }
        }
    }
}

struct PartnerScoreCard: View {
    let partner: Partner
    let score: Double

    var body: some View {
        VStack(spacing: 8) {
            PartnerBadge(partner: partner, size: 40)
            Text(partner.name)
                .font(.caption)
                .fontWeight(.medium)
            EffortBadge(score: score)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct PartnerTaskSection: View {
    let partner: Partner
    let tasks: [ChoreTask]
    let isCompleted: (ChoreTask) -> Bool
    let onComplete: (ChoreTask) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                PartnerBadge(partner: partner)
                Text(partner.name)
                    .font(.headline)
                Spacer()
                Text("\(tasks.filter { isCompleted($0) }.count)/\(tasks.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            if tasks.isEmpty {
                Text("No tasks assigned")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            } else {
                ForEach(tasks) { task in
                    TaskRow(task: task, isCompleted: isCompleted(task)) {
                        onComplete(task)
                    }
                }
            }
        }
        .padding()
        .cardStyle()
    }
}

struct TaskRow: View {
    let task: ChoreTask
    let isCompleted: Bool
    let onComplete: () -> Void

    var body: some View {
        Button(action: onComplete) {
            HStack(spacing: 12) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isCompleted ? .sageGreen : .secondary)
                    .font(.title3)

                VStack(alignment: .leading, spacing: 2) {
                    Text(task.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .strikethrough(isCompleted)
                        .foregroundColor(isCompleted ? .secondary : .primary)

                    HStack(spacing: 8) {
                        CategoryIcon(category: task.category, size: 12)

                        if task.isInvisible {
                            Image(systemName: "brain")
                                .font(.caption2)
                                .foregroundColor(.partnerCoral)
                        }

                        Text(task.frequency.shortLabel)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                EffortBadge(score: task.effortWeight.score, compact: true)
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}
