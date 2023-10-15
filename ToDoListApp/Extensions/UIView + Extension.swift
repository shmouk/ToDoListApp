import UIKit

extension UIView {
    func roundCornersToEllipse() {
        let radius = min(frame.width, frame.height) / 2.0
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
