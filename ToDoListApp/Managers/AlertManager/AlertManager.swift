import UIKit

class AlertManager {
    static func showAlert(title: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        viewController.present(alertController, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    static func showConfirmationAlert(title: String = DefaultText.message, message: String, viewController: UIViewController, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            completion()
        }
        alertController.addAction(confirmAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}

