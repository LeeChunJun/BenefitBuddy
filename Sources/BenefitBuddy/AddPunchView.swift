import SwiftUI

struct AddPunchView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var storage = StorageManager.shared

    @State private var selectedType = "读书"
    @State private var date = Date()
    @State private var note = ""

    let types = ["读书", "运动", "爬山", "编程", "写作", "其他"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("打卡类型")) {
                    Picker("类型", selection: $selectedType) {
                        ForEach(types, id: \.self) { type in
                            Text(type)
                        }
                    }
                }

                Section(header: Text("日期")) {
                    DatePicker("日期", selection: $date, displayedComponents: .date)
                }

                Section(header: Text("备注（可选）")) {
                    TextField("备注", text: $note)
                }
            }
            .navigationTitle("添加打卡")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        let entry = PunchEntry(date: date, type: selectedType, note: note.isEmpty ? nil : note)
                        storage.add(entry)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}