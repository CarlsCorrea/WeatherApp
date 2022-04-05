import UIKit

class LocationViewController: UIViewController {
    
    let locationView = LocationView()
    let locationManager: LocationManager?
    
    var isLocationUseAuthorized: Bool {
        guard let isAuthorized = locationManager?.isAuthorized() else { return false }
        return isAuthorized == .authorizedWhenInUse || isAuthorized == .authorizedAlways
    }
    
    init(locationManager: LocationManager?) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        locationView.allowLocationButton.addTarget(self, action: #selector(allowLocationButtonTapped), for: .touchUpInside)
        self.view = locationView
        
        if isLocationUseAuthorized {
            presentWeatherController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func allowLocationButtonTapped() {
        if (isLocationUseAuthorized) {
            presentWeatherController()
        } else {
            locationView.allowLocationButton.setTitle("ok, show me the forecast!", for: .normal)
            locationManager?.requestauthorization()
        }
    }
    
    func presentWeatherController() {
        let networkManager = NetworkManager()
        let locationServices = LocationService(locationManager: LocationManager())
        let weatherServices = WeatherService(networkManager: networkManager)
        let viewController = WeatherViewController(weatherServices: weatherServices, locationServices: locationServices)
        navigationController?.present(viewController, animated: true)
    }
    
}

