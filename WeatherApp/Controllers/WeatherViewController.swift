import UIKit

class WeatherViewController: UIViewController {
    
    let weatherView = WeatherView()
    let weatherServices: WeatherService?
    let locationServices: LocationService?
    var weatherData: WeatherData?
    var city:String?
    
    init(weatherServices: WeatherService?, locationServices:LocationService) {
        self.weatherServices = weatherServices
        self.locationServices = locationServices
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        weatherView.tableView.delegate = self
        weatherView.tableView.dataSource = self
        self.view = weatherView
        
        DispatchQueue.main.async {
            self.weatherView.spinner.startAnimating()
        }
        
        
        self.locationServices?.fetchUserLocation() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userLocation):
                self.fetchData(latitude:userLocation.latitude, longitude:userLocation.longitude)
            case .failure:
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                    //TODO: implement and Alert Class or something to notify the user
                }
                break
            }
        }
        
    }
    
    func fetchData(latitude:Double, longitude:Double) {
        
        self.weatherServices?.fetchWeatherData(latitude: "\(latitude)",
                                               longitude: "\(longitude)") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let weatherData):
                self.weatherData = weatherData
                
                self.locationServices?.fetchCity(location: Location(latitude: latitude, longitude: longitude)) { city, countryCode, error in
                    guard let city = city, let countryCode = countryCode, error == nil else {
                        print("Error occurred while fetching city and country")
                        DispatchQueue.main.async {
                            self.dismiss(animated: true)
                        }
                        return
                    }
                    
                    self.city = city + ", " + countryCode
                    DispatchQueue.main.async {
                        self.weatherView.tableView.reloadData()
                        self.weatherView.spinner.stopAnimating()
                    }
                }
                
                break
            case .failure:
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
                break
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CurrentWeatherHeaderView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
        if let current = weatherData?.current {
            headerView.configureView(current: current, city:self.city)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier) as? WeatherCell else {
            fatalError("could not cast cell")
        }
        if let daily = weatherData?.daily[indexPath.row] {
            cell.configureCell(dailyWeather: daily)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}

