import ActivityKit

struct EorzeaTimeAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var eorzeaTime: String
    }
    
    var name: String
}
