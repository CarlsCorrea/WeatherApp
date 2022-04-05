import UIKit

class LabelBase: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.frame = CGRect.init(x: 5, y: 5, width: frame.width, height: frame.height)
        self.font = .systemFont(ofSize: 16)
        self.numberOfLines = 0
        self.textAlignment = .center
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
