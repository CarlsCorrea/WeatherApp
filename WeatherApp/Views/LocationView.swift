import UIKit

final class LocationView: UIView {
    
    lazy var allowLocationButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect.init(x: 10, y: 25, width: 25, height: 25);
        button.setTitle("ok, show me the forecast!", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 9
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var allowLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
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
    
}

extension LocationView: ViewCode {
    
    func viewHierarchy() {
        addSubview(allowLocationLabel)
        addSubview(allowLocationButton)
    }

    func setupConstraints() {
        allowLocationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        allowLocationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        allowLocationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        allowLocationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        
        allowLocationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        allowLocationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        allowLocationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        allowLocationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
    }

    func aditionalSetup() {
        self.backgroundColor = .systemBlue
        allowLocationLabel.text = "This apps requires access to your device's location to get the forecast based on your region."
    }
    
}
