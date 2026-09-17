import SwiftUI
import Charts

struct StatsView: View {
    @StateObject private var storage = StorageManager.shared

    private var entries: [PunchEntry] {
        storage.load()
    }

    private var totalCount: Int {
        entries.count
    }

    private var weekCount: Int {
        let weekAgo = Date().addingTimeInterval(-7 * 24 * 60 * 60)
        return entries.filter { $0.date >= weekAgo }.count
    }

    private var monthCount: Int {
        let monthAgo = Date().addingTimeInterval(-30 * 24 * 60 * 60)
        return entries.filter { $0.date >= monthAgo }.count
    }

    private var typeCounts: [String: Int] {
        var counts: [String: Int] = [:]
        for entry in entries {
            counts[entry.type, default: 0] += 1
        }
        return counts
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("总计: \(totalCount) 天")
                        .font(.title2)
                        .bold()

                    Text("本周: \(weekCount) 天")
                    Text("本月: \(monthCount) 天")

                    if !typeCounts.isEmpty {
                        Text("类型分布")
                            .font(.headline)

                        Chart {
                            ForEach(Array(typeCounts.keys.sorted()), id: \.self) { type in
                                BarMark(
                                    x: .value("类型", type),
                                    y: .value("次数", typeCounts[type] ?? 0)
                                )
                            }
                        }
                        .frame(height: 200)
                        .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("统计")
        }
    }
}