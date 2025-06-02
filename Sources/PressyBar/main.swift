import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var timer: Timer?
    var isRunning = false

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.target = self
            button.action = #selector(togglePressy)
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        updateIcon()
    }

    func updateIcon() {
        if let button = statusItem.button {
            let iconName = isRunning ? "capslock.fill" : "capslock"
            button.image = NSImage(systemSymbolName: iconName, accessibilityDescription: "Pressy")
        }
    }

    @objc func togglePressy(_ sender: NSStatusBarButton) {
        let event = NSApp.currentEvent

        if event?.type == .rightMouseUp {
            showMenu()
        } else {
            isRunning.toggle()
            if isRunning {
                startPressy()
            } else {
                stopPressy()
            }
        }
    }

    func showMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "About PressyBar", action: #selector(showAboutWindow), keyEquivalent: "i"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApp.terminate), keyEquivalent: "q"))
        statusItem.menu = menu
        statusItem.button?.performClick(nil)
        statusItem.menu = nil
    }

    func startPressy() {
        scheduleNextKeyPress()
        updateIcon()
    }

    func stopPressy() {
        timer?.invalidate()
        timer = nil
        updateIcon()
    }

    func scheduleNextKeyPress() {
        let interval = Double.random(in: 10...50)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            self?.simulateCapsLock()
            if self?.isRunning == true {
                self?.scheduleNextKeyPress()
            }
        }
    }

    func simulateCapsLock() {
        let keyCode: CGKeyCode = 57
        let source = CGEventSource(stateID: .hidSystemState)
        let down = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: true)
        let up = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: false)
        down?.post(tap: .cghidEventTap)
        up?.post(tap: .cghidEventTap)
    }

    @objc func showAboutWindow() {
        let alert = NSAlert()
        alert.messageText = "PressyBar"
        alert.informativeText = "A lightweight macOS menu bar app that simulates periodic keypresses to keep your session active.\n\nCreated by KusW3"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.accessory)
app.run()
