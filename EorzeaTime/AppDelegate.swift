import UIKit
import UserNotifications
import ActivityKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard let activityId = userInfo["activityId"] as? String else {
            completionHandler(.failed)
            return
        }
        updateLiveActivity(activityId: activityId)
        completionHandler(.newData)
    }

    func updateLiveActivity(activityId: String) {
        let updatedContentState = EorzeaTimeAttributes.ContentState(eorzeaTime: getEorzeaTimeString(twentyFourHourTime: true))
        Task {
            if let activity = Activity<EorzeaTimeAttributes>.activities.first(where: { $0.id == activityId }) {
                await activity.update(.init(state: updatedContentState, staleDate: nil))
                print("Live Activity updated in background: \(updatedContentState.eorzeaTime)")
            }
        }
    }
}
