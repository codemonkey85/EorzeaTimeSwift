import Foundation

func toEorzeaTime(date: Date) -> Date {
    let eorzeaMultiplier = 3600.0 / 175.0
    
    // Calculate how many seconds have elapsed since 1/1/1970
    let epochSeconds = date.timeIntervalSince1970
    
    // Multiply those seconds by the Eorzea multiplier (approx 20.5x)
    let eorzeaSeconds = epochSeconds * eorzeaMultiplier
    
    return Date(timeIntervalSince1970: eorzeaSeconds)
}

func getEorzeaTime(twentyFourHourTime: Bool) -> String {
    let currentDate = Date()
    let eorzeaDate = toEorzeaTime(date: currentDate)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = twentyFourHourTime ? "HH:mm" : "hh:mm a"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let dateString = dateFormatter.string(from: eorzeaDate)
    return dateString
}
