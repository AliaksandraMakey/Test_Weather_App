
import Foundation


public func getLocalTime(timeZone: Int?) -> String? {
    let dateFormatter = DateFormatter()
    if (timeZone != nil) {
        let tz = TimeZone(secondsFromGMT: timeZone!)
        dateFormatter.timeZone = tz
    }
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: Date.now)
}

public func dateFormaterDaysFromStringToData(str time: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-dd-MM"
    return dateFormatter.date(from: time) ?? Date()
}

public func dateFormaterDaysFromDateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    dateFormatter.locale = Locale(languageCode: .english)
    return dateFormatter.string(from: date)
}

public func dateFormaterUnixtimeFromStringToData(int time: Int) -> Date {
    let time = TimeInterval(time)
    let date = Date(timeIntervalSince1970: time)
    return date
}


