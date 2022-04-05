import Foundation

extension URL {
    
    static func weatherEndpoint(lat: String,
                                long: String) -> URL {
        URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=hourly,minutely&units=metric&appid=\(APIManager.shared.getAPIKey())")!
    }
}
