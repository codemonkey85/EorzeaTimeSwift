import WidgetKit
import SwiftUI
import ActivityKit

struct EorzeaTimeLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EorzeaTimeAttributes.self) { context in
            // Lock screen/banner UI
            VStack {
                Text("Eorzea Time")
                    .font(.headline)
                Text(context.state.eorzeaTime)
                    .font(.largeTitle)
            }
            .padding()
        } dynamicIsland: { context in
            // Dynamic Island implementation
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Eorzea Time")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.eorzeaTime)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Updated at \(Date())")
                }
            } compactLeading: {
                Text("Eorzea")
            } compactTrailing: {
                Text(context.state.eorzeaTime)
            } minimal: {
                Text("E")
            }
        }
    }
}
