import Foundation

func toEorzeaTime(date: Date = Date()) -> Date {
    let eorzeaMultiplier = 3600.0 / 175.0
    
    // Calculate how many seconds have elapsed since 1/1/1970
    let epochSeconds = date.timeIntervalSince1970
    
    // Multiply those seconds by the Eorzea multiplier (approx 20.5x)
    let eorzeaSeconds = epochSeconds * eorzeaMultiplier
    
    return Date(timeIntervalSince1970: eorzeaSeconds)
}

func getEorzeaTimeString(twentyFourHourTime: Bool) -> String {
    let eorzeaDate = toEorzeaTime()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = twentyFourHourTime ? "HH:mm" : "hh:mm a"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let dateString = dateFormatter.string(from: eorzeaDate)
    return dateString
}
