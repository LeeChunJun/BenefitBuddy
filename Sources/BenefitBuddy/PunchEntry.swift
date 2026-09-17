import Foundation

struct PunchEntry: Identifiable, Codable {
    let id = UUID()
    let date: Date
    let type: String
    let note: String?
}