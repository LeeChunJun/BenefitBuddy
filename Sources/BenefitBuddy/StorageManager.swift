import Foundation

@MainActor
final class StorageManager: ObservableObject {
    static let shared = StorageManager()
    private let userDefaultsKey = "punchEntries"

    @Published private(set) var entries: [PunchEntry] = []

    private init() {
        entries = loadFromDisk()
    }

    func add(_ entry: PunchEntry) {
        entries.append(entry)
        persist()
    }

    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        persist()
    }

    private func loadFromDisk() -> [PunchEntry] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let decoded = try? JSONDecoder().decode([PunchEntry].self, from: data) else {
            return []
        }
        return decoded
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
}
