import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PunchListView()
                .tabItem { Label("列表", systemImage: "list.bullet") }
            StatsView()
                .tabItem { Label("统计", systemImage: "chart.bar") }
            AddPunchView()
                .tabItem { Label("添加", systemImage: "plus") }
        }
    }
}
