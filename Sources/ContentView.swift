import SwiftUI

private struct SubmissionRecord {
    let submittedAt: Date
    let fullName: String
    let email: String
    let passwordMask: String
    let role: String
    let birthday: Date
    let attendeeCount: Int
    let receiveNotifications: Bool
    let joinWorkshop: Bool
    let experienceScore: Double
    let notes: String
}

struct ContentView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var selectedRole = "工程"
    @State private var birthday = Calendar.current.date(byAdding: .year, value: -25, to: .now) ?? .now
    @State private var attendeeCount = 1
    @State private var receiveNotifications = true
    @State private var joinWorkshop = false
    @State private var experienceScore = 3.0
    @State private var notes = ""
    @State private var submittedRecord: SubmissionRecord?

    private let roles = ["产品", "设计", "工程", "运营"]

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            formPanel
            submissionPanel
        }
        .padding(20)
        .frame(minWidth: 980, minHeight: 640, alignment: .topLeading)
    }

    private var formPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SwiftUI Form Demo")
                .font(.largeTitle.bold())

            Text("常见输入组件放左侧；点击提交后，右侧显示最后一次提交快照。")
                .foregroundStyle(.secondary)

            Form {
                Section("基础信息") {
                    TextField("姓名", text: $fullName)
                        .textFieldStyle(.roundedBorder)

                    TextField("邮箱", text: $email)
                        .textFieldStyle(.roundedBorder)

                    SecureField("密码", text: $password)
                        .textFieldStyle(.roundedBorder)

                    Picker("角色", selection: $selectedRole) {
                        ForEach(roles, id: \.self) { role in
                            Text(role)
                        }
                    }
                }

                Section("偏好设置") {
                    DatePicker("生日", selection: $birthday, displayedComponents: .date)

                    Stepper(value: $attendeeCount, in: 1...10) {
                        Text("参会人数：\(attendeeCount)")
                    }

                    Toggle("接收通知", isOn: $receiveNotifications)
                    Toggle("参加会后 workshop", isOn: $joinWorkshop)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Swift 熟练度")
                            Spacer()
                            Text(scoreLabel(experienceScore))
                                .foregroundStyle(.secondary)
                        }

                        Slider(value: $experienceScore, in: 0...5, step: 0.5)
                    }
                }

                Section("补充说明") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 140)

                    Text("备注字数：\(notes.count)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Section {
                    Button("Submit 提交") {
                        submitForm()
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .center)

                    Button("重置") {
                        resetForm()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .formStyle(.grouped)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private var submissionPanel: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("最后一次提交")
                .font(.title2.bold())

            if let submittedRecord {
                Group {
                    summaryRow("提交时间", submittedRecord.submittedAt.formatted(date: .abbreviated, time: .shortened))
                    summaryRow("姓名", submittedRecord.fullName)
                    summaryRow("邮箱", submittedRecord.email)
                    summaryRow("密码", submittedRecord.passwordMask)
                    summaryRow("角色", submittedRecord.role)
                    summaryRow("生日", submittedRecord.birthday.formatted(date: .abbreviated, time: .omitted))
                    summaryRow("参会人数", "\(submittedRecord.attendeeCount)")
                    summaryRow("接收通知", boolLabel(submittedRecord.receiveNotifications))
                    summaryRow("参加 workshop", boolLabel(submittedRecord.joinWorkshop))
                    summaryRow("Swift 熟练度", scoreLabel(submittedRecord.experienceScore))

                    VStack(alignment: .leading, spacing: 6) {
                        Text("备注")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text(submittedRecord.notes)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .background(Color.secondary.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            else {
                Text("还没提交。先填左侧表单，再点 Submit。")
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)
        }
        .padding(20)
        .frame(minWidth: 320, maxWidth: 320, maxHeight: .infinity, alignment: .topLeading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func summaryRow(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
        }
    }

    private func submitForm() {
        submittedRecord = SubmissionRecord(
            submittedAt: .now,
            fullName: normalized(fullName, fallback: "未填写"),
            email: normalized(email, fallback: "未填写"),
            passwordMask: passwordMask,
            role: selectedRole,
            birthday: birthday,
            attendeeCount: attendeeCount,
            receiveNotifications: receiveNotifications,
            joinWorkshop: joinWorkshop,
            experienceScore: experienceScore,
            notes: normalized(notes, fallback: "无")
        )
    }

    private func resetForm() {
        fullName = ""
        email = ""
        password = ""
        selectedRole = roles[2]
        birthday = Calendar.current.date(byAdding: .year, value: -25, to: .now) ?? .now
        attendeeCount = 1
        receiveNotifications = true
        joinWorkshop = false
        experienceScore = 3.0
        notes = ""
    }

    private func normalized(_ value: String, fallback: String) -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? fallback : trimmed
    }

    private var passwordMask: String {
        let count = max(password.count, 0)
        return count == 0 ? "未填写" : String(repeating: "•", count: max(count, 6))
    }

    private func boolLabel(_ value: Bool) -> String {
        value ? "是" : "否"
    }

    private func scoreLabel(_ value: Double) -> String {
        String(format: "%.1f / 5", value)
    }
}
