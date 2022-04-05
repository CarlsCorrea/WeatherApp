struct Current: Codable {
    let dt: Int
    let temp: Double
    let pressure: Int?
    let humidity: Float?
    let temp_min: Double?
    let temp_max: Double?
    let weather: [WeatherConditions]
}

struct Daily: Codable {
    let dt: Int
    let pressure: Int?
    let humidity: Float?
    let weather: [WeatherConditions]
    let temp: Temp
}

struct WeatherConditions: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherData: Codable {
    let current: Current
    let daily: [Daily]
}

struct Temp:Codable {
    let min: Double
    let max: Double
    let day: Double
}
