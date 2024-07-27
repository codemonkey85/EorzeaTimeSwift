import Foundation
import UserNotifications
import ActivityKit

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationHandler()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
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
