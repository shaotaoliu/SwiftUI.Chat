import SwiftUI

@main
struct ChatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ChatsViewModel())
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
