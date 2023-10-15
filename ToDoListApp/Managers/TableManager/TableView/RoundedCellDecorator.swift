import UIKit

final class RoundedCellDecorator {
    static func roundCorners(at indexPath: IndexPath, totalRows: Int, for cell: UITableViewCell, cornerRadius: CGFloat) {
        var orientation: UIRectCorner = [.allCorners]

        if indexPath.row == 0 {
               orientation = [.topLeft, .topRight]
           }
           if indexPath.row == totalRows - 1 {
               orientation = [.bottomLeft, .bottomRight]
           }
           if totalRows == 1 {
               orientation = [.allCorners]
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
