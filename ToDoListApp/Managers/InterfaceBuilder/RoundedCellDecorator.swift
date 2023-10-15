import UIKit

final class RoundedCellDecorator {
    static func roundCorners(count: Int, for cell: UITableViewCell, cornerRadius: CGFloat) {
        var orientation: UIRectCorner = [.allCorners]
        
        switch count {
        case 0:
            orientation = [.topLeft, .topRight]
        case 1:
            orientation = [.allCorners]
        default:
            orientation = [.topLeft, .topRight]
        }
        var maskPath = UIBezierPath()
        
        maskPath = UIBezierPath(roundedRect: cell.bounds,
                                byRoundingCorners: orientation,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        
        cell.layer.mask = maskLayer
    }
}
