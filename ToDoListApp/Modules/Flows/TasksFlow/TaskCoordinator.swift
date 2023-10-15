import UIKit

class TaskCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setupAppearance()
    }

    func start() {
        let viewController = TasksTableViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentAddedTaskViewController() {
        let viewController = AddingTaskViewController()
        navigationController.modalPresentationStyle = .custom
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.present(viewController, animated: true)
        }
    }
}

