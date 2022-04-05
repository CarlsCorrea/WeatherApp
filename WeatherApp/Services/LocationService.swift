import Foundation

class LocationService {

    let locationManager: LocationManagerProtocol?
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }
    
    func fetchUserLocation(completion: @escaping FetchLocationCompletion) {
        self.locationManager?.fetchLocation() { result in
            switch result {
            case .success(let location):
                completion(.success(Location(latitude: location.latitude, longitude: location.longitude)))
            case .failure(let error):
                completion(.failure(ErrorsEnum.errorObteiningData(error.localizedDescription)))
            }
        }
    }
    
    func fetchCity(location:Location, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        self.locationManager?.fetchCityAndCountry(from: location) { city, countryCode, error in
            guard let city = city, let countryCode = countryCode, error == nil else {
                print("Error occurred while fetching city and country")
                completion(nil, nil, error)
                return
            }
            completion(city, countryCode, nil)
        }
    }
    
    
}

