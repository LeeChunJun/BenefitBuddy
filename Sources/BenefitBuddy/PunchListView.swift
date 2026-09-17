import SwiftUI

struct PunchListView: View {
    @StateObject private var storage = StorageManager.shared
    @State private var showingAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(storage.load()) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.type)
                            .font(.headline)
                        Text(entry.date, style: .date)
                            .font(.subheader)
                            .foregroundColor(.secondary)
                        if let note = entry.note, !note.isEmpty {
                            Text(note)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: storage.delete)
            }
            .navigationTitle("打卡记录")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddPunchView()
            }
        }
    }
}