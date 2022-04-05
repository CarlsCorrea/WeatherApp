import Foundation
import UIKit

enum WeatherEnum: String, CaseIterable {
    case clouds = "clouds"
    case clear = "clear"
    case rain = "rain"
    case snow = "snow"
    
    var imageName: String {
        switch self {
        case .clouds:
          return "smoke.fill"
        case .clear:
          return "sun.max.fill"
        case .rain:
          return "cloud.rain.fill"
        case .snow:
          return "snowflake"
        }
    }
    
    var imageColor: UIColor {
        switch self {
        case .clouds:
            return .white
        case .clear:
            return .yellow
        case .rain:
            return .white
        case .snow:
            return .white
        }
    }
    
}
