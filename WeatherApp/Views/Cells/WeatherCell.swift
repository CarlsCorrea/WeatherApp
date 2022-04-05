import Foundation
import UIKit

final class WeatherCell: UITableViewCell {
    static let identifier = "weatherCell"
    
    lazy var imageViewWeather: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100.00))
        image.image = UIImage(systemName: WeatherEnum.clear.imageName)
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var labelDay: LabelBase = {
        let label = LabelBase()
        return label
    }()
    
    lazy var labelMax: LabelBase = {
        let label = LabelBase()
        return label
    }()
    
    lazy var labelMin: LabelBase = {
        let label = LabelBase()
        return label
    }()
    
    lazy var labelAverage: LabelBase = {
        let label = LabelBase()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(dailyWeather:Daily){
        let date = Date(timeIntervalSince1970: Double(dailyWeather.dt))
        labelDay.text = date.dayOfTheWeek()?.capitalizingFirstLetter() ?? ""
        labelMin.text = "Min: \(Int(dailyWeather.temp.min))"
        labelMax.text = "Max: \(Int(dailyWeather.temp.max))"
        labelAverage.text = "\(Int(dailyWeather.temp.day))"
        
        if let dailyFirst = dailyWeather.weather.first {
            WeatherEnum.allCases.forEach {
                if ($0.rawValue == dailyFirst.main.lowercased()) {
                    imageViewWeather.image = UIImage(systemName: $0.imageName)
                    imageViewWeather.tintColor = $0.imageColor
                }
            }
        }
        
    }
    
}

extension WeatherCell: ViewCode {
    func viewHierarchy() {
        contentView.addSubview(labelDay)
        contentView.addSubview(labelMin)
        contentView.addSubview(labelMax)
        contentView.addSubview(labelAverage)
        contentView.addSubview(imageViewWeather)
    }
    
    func setupConstraints() {
        labelDay.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        labelDay.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        labelMin.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        labelMin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        labelMax.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        labelMax.leadingAnchor.constraint(equalTo: labelMin.trailingAnchor, constant: 10).isActive = true
        
        imageViewWeather.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        imageViewWeather.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        imageViewWeather.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageViewWeather.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        labelAverage.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        labelAverage.trailingAnchor.constraint(equalTo: imageViewWeather.leadingAnchor, constant: -10).isActive = true
        
//        labelAverage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
//        labelAverage.leadingAnchor.constraint(equalTo: labelMin.trailingAnchor, constant: 10).isActive = true
    }
    
    func aditionalSetup() {
        contentView.backgroundColor = .systemBlue
    }
    
}
