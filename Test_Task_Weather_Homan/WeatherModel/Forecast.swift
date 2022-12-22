

import Foundation

struct Forecast: Decodable {
    let date, dateTs: Date?
    let sunrise, sunset: String
    let day: String?
    let hours: [Hour]
    let parts: Parts
    
    enum ForecastKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case sunrise, sunset
        case hours, parts, day
      
    }
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: ForecastKeys.self)
        
        let newDate = try value.decode(String.self, forKey: .date)
        date = dateFormaterDaysFromStringToData(str: newDate)
        let newDateTs = try value.decode(Int.self, forKey: .dateTs)
        dateTs = dateFormaterUnixtimeFromStringToData(int: newDateTs)
        day = dateFormaterDaysFromDateToString(date: dateTs!)
        sunrise = try value.decode(String.self, forKey: .sunrise)
        sunset = try value.decode(String.self, forKey: .sunset)
        hours = try value.decode([Hour].self, forKey: .hours)
        parts = try value.decode(Parts.self, forKey: .parts)
    }
}
