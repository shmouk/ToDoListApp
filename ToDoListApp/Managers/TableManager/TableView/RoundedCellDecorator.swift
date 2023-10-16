import UIKit

final class RoundedCellDecorator {
    static func roundCorners(orientation: UIRectCorner = [.allCorners], for cell: UITableViewCell, cornerRadius: CGFloat) {
        var maskPath = UIBezierPath()
        
        maskPath = UIBezierPath(roundedRect: cell.bounds,
                                byRoundingCorners: orientation,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        
        cell.layer.mask = maskLayer
    }
}
