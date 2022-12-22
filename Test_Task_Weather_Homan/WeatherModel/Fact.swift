
import Foundation

struct Fact: Decodable {
    let cloudness, feelsLike, humidity: Double
    let condition: String
    let precType, pressurePa, precStrength: Double
    let temp: Int?
    let uvIndex, windSpeed: Double
    let windGust: Double?
    let windDir: String?
    
    enum FactKeys: String, CodingKey {
        case cloudness, condition, daytime
        case feelsLike = "feels_like"
        case humidity
        case precType = "prec_type"
        case pressurePa = "pressure_pa"
        case precStrength = "prec_strength"
        case temp
        case uvIndex = "uv_index"
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: FactKeys.self)
        cloudness = try value.decode(Double.self, forKey: .cloudness)
        condition = try value.decode(String.self, forKey: .condition)
        feelsLike = try value.decode(Double.self, forKey: .feelsLike)
        humidity = try value.decode(Double.self, forKey: .humidity)
        precType = try value.decode(Double.self, forKey: .precType)
        pressurePa = try value.decode(Double.self, forKey: .pressurePa)
        precStrength = try value.decode(Double.self, forKey: .precStrength)
        temp = try value.decode(Int?.self, forKey: .temp)
        uvIndex = try value.decode(Double.self, forKey: .uvIndex)
        windSpeed = try value.decode(Double.self, forKey: .windSpeed)
        windGust = try value.decode(Double.self, forKey: .windGust)
        windDir = try value.decode(String.self, forKey: .windDir)
    }
}
