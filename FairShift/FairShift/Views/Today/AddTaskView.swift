import SwiftUI
import SwiftData

struct AddTaskView: View {
    let partners: [Partner]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var category: ChoreCategory = .kitchen
    @State private var isInvisible = false
    @State private var effortWeight: EffortWeight = .medium
    @State private var frequency: TaskFrequency = .weekly
    @State private var ownershipType: OwnershipType = .fullOwnership
    @State private var selectedPartnerID: UUID?

    var body: some View {
        NavigationStack {
            Form {
                Section("Task Details") {
                    TextField("Task name", text: $title)

                    Picker("Category", selection: $category) {
                        ForEach(ChoreCategory.allCases, id: \.self) { cat in
                            Label(cat.rawValue, systemImage: cat.icon).tag(cat)
                        }
                    }

                    Toggle("Invisible Load", isOn: $isInvisible)
                }

                Section("Effort & Frequency") {
                    Picker("Effort Level", selection: $effortWeight) {
                        ForEach(EffortWeight.allCases, id: \.self) { effort in
                            Text("\(effort.rawValue) (\(effort.estimatedRange))").tag(effort)
                        }
                    }

                    Picker("Frequency", selection: $frequency) {
                        ForEach(TaskFrequency.allCases, id: \.self) { freq in
                            Text(freq.shortLabel).tag(freq)
                        }
                    }
                }

                Section("Ownership") {
                    Picker("Type", selection: $ownershipType) {
                        Text(OwnershipType.fullOwnership.rawValue).tag(OwnershipType.fullOwnership)
                        Text(OwnershipType.sharedOwnership.rawValue).tag(OwnershipType.sharedOwnership)
                        Text(OwnershipType.delegatedExecution.rawValue).tag(OwnershipType.delegatedExecution)
                    }

                    if !partners.isEmpty {
                        Picker("Assigned to", selection: $selectedPartnerID) {
                            Text("Unassigned").tag(nil as UUID?)
                            ForEach(partners) { partner in
                                Text(partner.name).tag(partner.id as UUID?)
                            }
                        }
                    }
                }

                if isInvisible {
                    Section("Invisible Load Examples") {
                        ForEach(category.invisibleExamples, id: \.self) { example in
                            Button(example) {
                                title = example
                            }
                            .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { addTask() }
                        .disabled(title.isEmpty)
                }
            }
        }
    }

    private func addTask() {
        let task = ChoreTask(title: title, category: category, isInvisible: isInvisible)
        task.effortWeight = effortWeight
        task.frequency = frequency
        task.ownershipType = ownershipType
        task.mentalLoadScore = isInvisible ? 7 : 3

        if let partnerID = selectedPartnerID,
           let partner = partners.first(where: { $0.id == partnerID }) {
            task.executionOwner = partner
            task.conceptionOwner = partner
            task.initiationOwner = partner
        }

        modelContext.insert(task)
        try? modelContext.save()
        dismiss()
    }
}
