# PressyBar

**PressyBar** is a lightweight macOS menu bar app that simulates Caps Lock key presses at random intervals to prevent idle lockouts or sleep triggers. It's useful in environments where periodic user activity is expected to keep sessions active.

## ✨ Features

- Lives in the macOS menu bar
- Start/Stop control for keypress simulation
- Randomized Caps Lock presses every 10–50 seconds
- Dynamic icon: filled `capslock.fill` when active, `capslock` when stopped
- Fully native Swift app (no Python dependencies)

## 🛠 Requirements

- macOS 11.0 or later
- Swift 5.7+ toolchain installed (`swift` CLI)
- Accessibility permissions enabled for the app

## 🚀 Getting Started

### 1. Clone the project

```bash
git clone https://github.com/yourusername/PressyBar.git
cd PressyBar
```

### 2. Install [Taskfile.dev](https://taskfile.dev/#/installation) CLI tool

```bash
brew install go-task/tap/go-task
```

### 3. Build, bundle, and launch the app

```bash
task
```

This will:

- Build the Swift binary
- Create a `.app` bundle at `Packages/PressyBar.app`
- Open the app

### 4. Install (Optional)

```bash
task install
```

This will:

- Move the app into user's Application folder. This makes it visible to the wider system.

## 📦 App Bundle Layout

The `.app` bundle will be generated in:

```
Packages/PressyBar.app/
├── Contents/
│   ├── Info.plist
│   ├── MacOS/
│   │   └── PressyBar
│   └── Resources/
```

> The `Info.plist` sets `LSUIElement = true` so the app runs only in the menu bar (no Dock icon or Cmd+Tab presence).

## 🔐 Grant Accessibility Permissions

To simulate key presses, you must allow access:

1. Go to **System Settings → Privacy & Security → Accessibility**
2. Click `+`, add `Packages/PressyBar.app`
3. Ensure it's checked ✅

## 🧪 Development Structure

```
.
├── Taskfile.yml      # Build automation using taskfile.dev
├── Package.swift     # SwiftPM project definition
└── Sources/
    └── PressyBar/
        └── main.swift  # App logic and keypress simulation
```

## 📄 License

MIT © 2025 \[KusW3]

## 💡 Tip

To have it start on login:

- Add `Packages/PressyBar.app` to **Login Items** in System Settings
