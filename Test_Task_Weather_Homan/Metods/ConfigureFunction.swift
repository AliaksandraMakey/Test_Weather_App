
import UIKit

func factPrecStrengthFunction(_ with: Double) -> String{
    switch with {
    case 0:
         return "no"
    case 0.25:
        return "light"
    case 0.5:
        return "medium"
    case 0.75, 1:
        return "heavy"
    default:
        return " "
    }
}

func windGustAndDirFunction(_ oneValue: String?, _ twoValue: String) -> String {
    let value = oneValue?.lowercased()
    switch value {
    case "nw":
        //"северо-западное"
        return "North-west wind direction. \(twoValue)"
    case "n":
        //"северное"
        return "North wind direction.  \(twoValue)"
    case "ne":
        // "северо-восточное"
        return "North-east wind direction. \(twoValue)"
    case "e":
        // "восточное"
        return "East wind direction. \(twoValue)"
    case "se":
        // "юго-восточное"
        return  "South-east wind direction. \(twoValue)"
    case "s":
        // "южное"
        return  "South wind direction. \(twoValue)"
    case "sw":
        // "юго-западное"
        return "South-west wind direction. \(twoValue)"
    case "w":
        // "западное"
        return  "West wind direction. \(twoValue)"
    case "c":
        // "штиль"
        return  "Calm. \(twoValue)"
    default:
      return " "
    }
}

func iconImageFunction(_ with: String) -> UIImage? {
    let value = with.lowercased()
    switch value {
    case "clear":
        return UIImage(named: "IconWeather-1b")
    case "partly-cloudy":
        return UIImage(named: "IconWeather-2b")
    case "cloudy", "overcast":
        return UIImage(named: "IconWeather-3b")
    case  "light-rain", "rain", "moderate-rain", "drizzle", "heavy-rain", "continuous-heavy-rain", "showers":
        return UIImage(named: "IconWeather-4b")
    case "hail", "thunderstorm", "thunderstorm-with-rain", "thunderstorm-with-hail":
        return UIImage(named: "IconWeather-5b")
    case "wet-snow", "light-snow", "snow", "snow-showers":
        return UIImage(named: "IconWeather-6b")
    default:
        return UIImage(named:"IconWeather-7b")
    }
}
