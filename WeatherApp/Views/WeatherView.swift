import UIKit

final class WeatherView: UIView {
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 130, height: 130.00))
        spinner.style = UIActivityIndicatorView.Style.medium
        spinner.tintColor = .yellow
        spinner.backgroundColor = .clear
        spinner.hidesWhenStopped = true
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .systemBlue
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherView: ViewCode {
    func viewHierarchy() {
        addSubview(tableView)
        addSubview(spinner)
    }
    
    func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor).isActive = true
    }
    
    func aditionalSetup() {
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        tableView.separatorColor = .white
    }
    
}
