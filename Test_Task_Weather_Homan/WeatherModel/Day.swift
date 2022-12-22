
import Foundation

struct Day: Decodable {
    let source, condition: String
    let humidity, tempAvg: Double
    let tempMin, tempMax: Double
    
    
    enum DayKeys: String, CodingKey {
        case source = "_source"
        case  condition, humidity
        case tempAvg = "temp_avg"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: DayKeys.self)
        source = try value.decode(String.self, forKey: .source)
        condition = try value.decode(String.self, forKey: .condition)
        humidity = try value.decode(Double.self, forKey: .humidity)
        tempAvg = try value.decode(Double.self, forKey: .tempAvg)
        tempMin = try value.decode(Double.self, forKey: .tempMin)
        tempMax = try value.decode(Double.self, forKey: .tempMax)
    }
}
