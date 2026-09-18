import Foundation

struct PunchEntry: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let type: String
    let note: String?
}