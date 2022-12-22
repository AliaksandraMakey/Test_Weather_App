
import Foundation
import Alamofire

class WeatherService {
    
    
    func loadWeatherData(city: String, lon: Double, lat: Double, limit: Int, extra: Bool, hours: Bool, complitionHandler: @escaping (WeatherResponse) -> Void){
        DispatchQueue.global().async {
            let url =  "https://api.weather.yandex.ru/v2/forecast?"
            let headers: HTTPHeaders = [
                "X-Yandex-API-Key" : "0cdc2e58-44fa-416c-ad80-0ff33d18b7c8"]
            
            
            let parameters: Parameters = [
                "lat": lat,
                "lon": lon,
                "lang": "en_US",
                "extra": extra,
                "hours": hours,
                "limit": limit,
            ]
            
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { response in
                switch response.result {
                case .success:
                    guard let data = response.data else {return}
                    
                    let jsonString = String(decoding: data, as: UTF8.self)
                    do {
                        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: Data(jsonString.utf8))
                        
                        complitionHandler(weatherResponse)
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
