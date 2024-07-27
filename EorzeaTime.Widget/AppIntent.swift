import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "Displays the current time in Eorzea." }

    @Parameter(title: "24 Hour Time", default: false)
    var twentyFourHourTime: Bool
}
