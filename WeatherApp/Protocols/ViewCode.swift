
protocol ViewCode {
    func viewHierarchy()
    func setupConstraints()
    func aditionalSetup()
    func setUpViews()
}

extension ViewCode {
    func setUpViews() {
        viewHierarchy()
        setupConstraints()
        aditionalSetup()
    }
}
