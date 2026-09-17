import Foundation

class StorageManager {
    static let shared = StorageManager()
    private let userDefaultsKey = "punchEntries"

    private init() {}

    func load() -> [PunchEntry] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let entries = try? JSONDecoder().decode([PunchEntry].self, from: data) else {
            return []
        }
        return entries
    }

    func save(_ entries: [PunchEntry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func add(_ entry: PunchEntry) {
        var entries = load()
        entries.append(entry)
        save(entries)
    }

    func delete(at offsets: IndexSet) {
        var entries = load()
        entries.remove(atOffsets: offsets)
        save(entries)
    }
}