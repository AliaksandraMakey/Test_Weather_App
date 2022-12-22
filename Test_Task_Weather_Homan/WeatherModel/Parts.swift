
import Foundation

struct Parts: Decodable {
    let day, night: Day
    
    enum PartsKeys: String, CodingKey {
        case day, night
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: PartsKeys.self)
        day = try value.decode(Day.self, forKey: .day)
        night = try value.decode(Day.self, forKey: .night)
    }
}
