import UIKit

extension UIViewController {
    func customTableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        var orientation: UIRectCorner = []
        
        if indexPath.row == 0 {
            orientation = [.topLeft, .topRight]
        }
        if indexPath.row == totalRows - 1 {
            orientation = [.bottomLeft, .bottomRight]
        }
        if totalRows == 1 {
            orientation = [.allCorners]
        }
        RoundedCellDecorator.roundCorners(orientation: orientation, for: cell, cornerRadius: 10.0)
    }
}
