# SwiftUI macOS Form 表单布局

## 简介

演示 SwiftUI `Form` 如何组合常见表单组件。

这个 demo 左侧是可编辑表单，右侧是“最后一次提交”结果。点击 `Submit` 后，会把当次内容冻结并展示出来。

## 快速开始

```bash
cd swiftui-macos-form-demo
xcodegen generate
open SwiftUIFormDemo.xcodeproj
# Cmd+R 运行
```

## 包含的组件

1. `TextField`
2. `SecureField`
3. `Picker`
4. `DatePicker`
5. `Stepper`
6. `Toggle`
7. `Slider`
8. `TextEditor`
9. `Button`

## 运行后看什么

1. 左侧填姓名、邮箱、密码、角色
2. 调整生日、参会人数、通知开关、workshop 开关、熟练度
3. 在备注里输入补充信息
4. 点击 `Submit 提交`
5. 右侧立即显示这次提交的全部内容

## 原理

核心点只有 1 个：

点击提交时，不直接读右侧 UI，而是先把当前输入状态组装成 1 份 `SubmissionRecord` 快照，再由右侧只读展示。

这样能清楚演示：

- 表单正在编辑的状态
- 已提交的状态
- 两者是分开的

## 关键代码

```swift
@State private var submittedRecord: SubmissionRecord?

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
```
