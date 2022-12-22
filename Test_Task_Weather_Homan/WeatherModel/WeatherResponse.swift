
import Foundation

struct WeatherResponse: Decodable {
    let now: Date?
    let localTime: String?
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
    let geoObject: GeoObject
    
    enum WeatherResponseKeys: String, CodingKey {
        case now
        case localTime
        case info
        case fact
        case forecasts
        case geoObject = "geo_object"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: WeatherResponseKeys.self)
        info = try value.decode(Info.self, forKey: .info)
        let newCopy = try value.decode(Int.self, forKey: .now)
        now = dateFormaterUnixtimeFromStringToData(int: newCopy)
        localTime = getLocalTime(timeZone: info.tzinfo.offset)
        fact = try value.decode(Fact.self, forKey: .fact)
        forecasts = try value.decode([Forecast].self, forKey: .forecasts)
        geoObject = try value.decode(GeoObject.self, forKey: .geoObject)
    }
}
