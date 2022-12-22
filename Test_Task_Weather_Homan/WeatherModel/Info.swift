
import Foundation

struct Info: Decodable {
    let lat, lon: Double
    let tzinfo: Tzinfo
    
    enum InfoKeys: String, CodingKey {
        case lat, lon, tzinfo
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: InfoKeys.self)
        lat = try value.decode(Double.self, forKey: .lat)
        lon = try value.decode(Double.self, forKey: .lon)
        tzinfo = try value.decode(Tzinfo.self, forKey: .tzinfo)
    }
}
