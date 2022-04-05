import Foundation

typealias FetchWeatherDataCompletion = (Result<WeatherData,ErrorsEnum>) -> Void

class WeatherService {
    let networkManager: NetworkManager?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchWeatherData(latitude: String, longitude: String,completion: @escaping FetchWeatherDataCompletion) {
        self.networkManager?.fetchData(url: .weatherEndpoint(lat: latitude,
                                                             long: longitude)) { (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let weatherData):
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(ErrorsEnum.errorObteiningData(error.localizedDescription)))
            }
        }

    }

}
