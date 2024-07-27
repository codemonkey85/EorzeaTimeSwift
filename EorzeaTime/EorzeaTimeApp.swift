import SwiftUI
import UserNotifications

@main
struct EorzeaTimeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        requestNotificationPermissions()
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permissions granted.")
            } else {
                if let error = error {
                    print("Error requesting notification permissions: \(error.localizedDescription)")
                }
            }
        }
    }
}
