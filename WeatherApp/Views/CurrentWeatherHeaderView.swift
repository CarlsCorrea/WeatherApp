import UIKit

final class CurrentWeatherHeaderView: UIView {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(frame: .zero)
        stackView.distribution = .fillEqually
        stackView.axis  = .horizontal
        stackView.spacing = 1.0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100.00))
        image.image = UIImage(systemName: "sun.max.fill")
        image.tintColor = .yellow
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var labelTemp: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.frame = CGRect.init(x: 5, y: 5, width: frame.width, height: frame.height)
        label.font = .systemFont(ofSize: 48)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelCity: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.frame = CGRect.init(x: 5, y: 5, width: frame.width, height: frame.height)
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(current: Current, city: String?) {
        labelTemp.text = "\(String(describing: Int(current.temp))) ℃"
        
        if let city = city {
            labelCity.text = city
        }
        
        if let weather = current.weather.first {
            WeatherEnum.allCases.forEach {
                if ($0.rawValue == weather.main.lowercased()) {
                    imageView.image = UIImage(systemName: $0.imageName)
                    imageView.tintColor = $0.imageColor
                }
            }
        }
    }
    
}

extension CurrentWeatherHeaderView: ViewCode {
    func viewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelTemp)
        addSubview(labelCity)
    }
    
    func setupConstraints() {
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        labelCity.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        labelCity.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func aditionalSetup() {}
    
}
