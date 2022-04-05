import Foundation
import MapKit
import CoreLocation

typealias FetchLocationCompletion = (Result<Location,ErrorsEnum>) -> Void

protocol LocationManagerProtocol {
    func fetchLocation(completion: @escaping FetchLocationCompletion)
    func fetchCityAndCountry(from location: Location, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ())
}

class LocationManager: NSObject {
        
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private var didFetchLocationCompletion: FetchLocationCompletion?
    fileprivate var locationCompletion: FetchLocationCompletion?

}

extension LocationManager: LocationManagerProtocol {
    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        self.didFetchLocationCompletion = completion
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func requestauthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func isAuthorized() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFetchLocationCompletion?(.failure(ErrorsEnum.errorObteiningLocation(error.localizedDescription)))
        didFetchLocationCompletion = nil
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            self.locationManager.requestLocation()
        default:
            didFetchLocationCompletion?(.failure(ErrorsEnum.errorObteiningLocation("Error fetching location.")))
            didFetchLocationCompletion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        didFetchLocationCompletion?(.success(Location(latitude: latitude, longitude: longitude)))
        didFetchLocationCompletion = nil
    }
    
    func fetchCityAndCountry(from location: Location, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        CLGeocoder().reverseGeocodeLocation(clLocation) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.isoCountryCode,
                       error)
        }
    }
    
}
