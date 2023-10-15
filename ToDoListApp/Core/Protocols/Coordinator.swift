import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get }
    func start()
    func presentAddedTaskViewController()
}
