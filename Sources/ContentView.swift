import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var enableNotifications = true
    @State private var selectedColor = "蓝色"
    @State private var comments = ""

    let colors = ["蓝色", "红色", "绿色", "黄色"]

    var body: some View {
        Form {
            // 个人信息 Section
            Section("个人信息") {
                TextField("用户名", text: $username)
                    .textFieldStyle(.roundedBorder)

                TextField("邮箱", text: $email)
                    .textFieldStyle(.roundedBorder)

                SecureField("密码", text: $password)
                    .textFieldStyle(.roundedBorder)
            }

            // 设置 Section
            Section("设置") {
                Toggle("启用通知", isOn: $enableNotifications)

                Picker("主题颜色", selection: $selectedColor) {
                    ForEach(colors, id: \.self) { color in
                        Text(color)
                    }
                }
            }

            // 反馈 Section
            Section("反馈") {
                TextEditor(text: $comments)
                    .frame(height: 100)

                Text("字符数: \(comments.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // 操作 Section
            Section {
                Button("保存") {
                    saveForm()
                }
                .frame(maxWidth: .infinity)

                Button("重置") {
                    resetForm()
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderless)
            }
        }
        .formStyle(.grouped)
        .padding()
    }

    func saveForm() {
        print("保存: username=\(username), email=\(email)")
    }

    func resetForm() {
        username = ""
        email = ""
        password = ""
        enableNotifications = true
        selectedColor = "蓝色"
        comments = ""
    }
}
