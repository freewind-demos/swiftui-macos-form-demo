# SwiftUI macOS Form 表单布局

## 简介

演示 SwiftUI 中 Form 的用法，用于创建结构化的表单页面。

## 快速开始

```bash
cd swiftui-macos-form-demo
xcodegen generate
open SwiftUIFormDemo.xcodeproj
# Cmd+R 运行
```

## 概念讲解

### 基础 Form

```swift
Form {
    TextField("用户名", text: $username)
    TextField("邮箱", text: $email)
}
```

### Section 分组

```swift
Form {
    Section("个人信息") {
        TextField("用户名", text: $username)
        TextField("邮箱", text: $email)
    }

    Section("设置") {
        Toggle("启用通知", isOn: $enabled)
    }
}
```

### Form 样式

```swift
.formStyle(.grouped)
```

## 完整示例

```swift
struct SettingsView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section("账户") {
                TextField("用户名", text: $username)
                TextField("邮箱", text: $email)
            }

            Section {
                Button("保存") {
                    save()
                }
            }
        }
        .formStyle(.grouped)
    }
}
```

## 完整讲解（中文）

### Form 的特点

- 自动分组显示
- 原生 macOS 样式
- 适合设置页面、注册表单等

### Section 的作用

Section 将相关字段分组，提供视觉分隔和可选的标题。

### 使用场景

- 设置页面
- 用户资料编辑
- 注册/登录表单
- 任何需要分组输入的界面

### 与普通 VStack 的区别

Form 提供：
- 系统原生的分组样式
- 更好的 macOS 视觉一致性
- 自动处理键盘导航
