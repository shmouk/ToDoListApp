import UIKit

extension UINavigationController {
    func setupAppearance() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .tint
        appearance.titleTextAttributes = [.foregroundColor : UIColor.tint,
                                          .font: UIFont.systemFont(ofSize: 20, weight: .medium)]

        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.tintColor = .tint
    }
}
