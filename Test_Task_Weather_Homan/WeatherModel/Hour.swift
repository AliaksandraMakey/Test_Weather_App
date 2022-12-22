
import Foundation

struct Hour: Decodable {
    let condition, hour: String
    let temp: Int

    enum HourKeys: String, CodingKey {
        case condition, hour, humidity, temp
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: HourKeys.self)
        condition = try value.decode(String.self, forKey: .condition)
        hour = try value.decode(String.self, forKey: .hour)
        temp = try value.decode(Int.self, forKey: .temp)
    }
}
