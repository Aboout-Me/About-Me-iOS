import UIKit

class BottomSheetViewController: UIViewController {
    
    // 1
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    // 2
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 3
    private func setupUI() {
        view.addSubview(dimmedView)
        
        setupLayout()
    }
    
    // 4
    private func setupLayout() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
