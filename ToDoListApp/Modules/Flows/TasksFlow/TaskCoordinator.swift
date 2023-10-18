import UIKit

class TaskCoordinator: CoordinatorProtocol {
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setupAppearance()
    }
    
    func start() {
        let viewModel = TasksTableViewModel()
        let viewController = TasksTableViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension TaskCoordinator: TasksViewControllerDelegate {
    func openAddingTaskViewController() {
        let viewModel = AddingTaskViewModel()
        let viewController = AddingTaskViewController(viewModel: viewModel)
        navigationController.modalPresentationStyle = .custom
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        self.navigationController.present(viewController, animated: true)
    }
}
