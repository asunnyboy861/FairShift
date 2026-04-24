import SwiftUI
import SwiftData

struct LogView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TaskCompletion.completedAt, order: .reverse) private var completions: [TaskCompletion]
    @Query(sort: \Partner.createdAt) private var partners: [Partner]

    @State private var selectedFilter: LogFilter = .all

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filterBar

                if filteredCompletions.isEmpty {
                    Spacer()
                    EmptyStateView(
                        icon: "checkmark.circle",
                        title: "No Logs Yet",
                        subtitle: "Complete tasks to see your history here"
                    )
                    Spacer()
                } else {
                    List {
                        ForEach(groupedCompletions, id: \.key) { date, items in
                            Section {
                                ForEach(items) { completion in
                                    CompletionRow(completion: completion, partners: partners)
                                }
                            } header: {
                                Text(date)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Log")
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(LogFilter.allCases, id: \.self) { filter in
                    FilterChip(filter: filter, isSelected: selectedFilter == filter) {
                        selectedFilter = filter
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
    }

    private var filteredCompletions: [TaskCompletion] {
        switch selectedFilter {
        case .all: return completions
        case .invisible: return completions.filter { $0.wasInvisible }
        case .today: return completions.filter { Calendar.current.isDateInToday($0.completedAt) }
        case .thisWeek: return completions.filter { $0.completedAt >= Date().startOfWeek }
        }
    }

    private var groupedCompletions: [(key: String, value: [TaskCompletion])] {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return Dictionary(grouping: filteredCompletions) { completion in
            formatter.string(from: completion.completedAt)
        }
        .sorted { $0.key > $1.key }
        .map { (key: $0.key, value: $0.value) }
    }
}

enum LogFilter: String, CaseIterable {
    case all = "All"
    case today = "Today"
    case thisWeek = "This Week"
    case invisible = "Invisible"
}

struct FilterChip: View {
    let filter: LogFilter
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(filter.rawValue)
                .font(.caption)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? Color.sageGreen : Color(.secondarySystemBackground))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct CompletionRow: View {
    let completion: TaskCompletion
    let partners: [Partner]

    private var partner: Partner? {
        partners.first { $0.id == completion.partnerID }
    }

    var body: some View {
        HStack(spacing: 12) {
            if let partner {
                PartnerBadge(partner: partner, size: 32)
            } else {
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.secondary)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(completion.choreTask?.title ?? "Unknown Task")
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack(spacing: 8) {
                    Text("\(completion.minutesSpent) min")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if completion.wasInvisible {
                        Image(systemName: "brain")
                            .font(.caption2)
                            .foregroundColor(.partnerCoral)
                    }

                    if !completion.notes.isEmpty {
                        Image(systemName: "note.text")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }

            Spacer()

            Text(completion.completedAt.relativeString)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
