import CoreLocation
@testable import WeatherApp

class MockLocationManager: LocationManagerProtocol {  
    var location: Location = Location(latitude: 51.509865, longitude: -0.118092)

    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        completion(.success(location))
    }
    
}
