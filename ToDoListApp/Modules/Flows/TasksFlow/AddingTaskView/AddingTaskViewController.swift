import UIKit

class AddingTaskViewController: BaseViewController {
    private let viewModel = AddingTaskViewModel()

    var coordinator: CoordinatorProtocol?
    
    lazy var titleTextField = InterfaceBuilder.makeTextField()
    lazy var descriptionTextView = InterfaceBuilder.makeTextView()
    lazy var createTaskButton = InterfaceBuilder.makeButton(withTitle: "Create Task")
    lazy var titleLabel = InterfaceBuilder.makeLabel(title: "Title:")
    lazy var subtitleLabel = InterfaceBuilder.makeLabel(title: "Subtitle:")

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupResponsibilities()
    }
    
    private func setUI() {
        setSubviews()
        setupConstraints()
    }
    
    private func setSubviews() {
        view.addSubviews(titleLabel,
                         titleTextField,
                         subtitleLabel,
                         descriptionTextView,
                         createTaskButton)
    }
    
    private func setupResponsibilities() {
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        
        createTaskButton.addTarget(self, action: #selector(createTaskTapped), for: .touchUpInside)
    }
}

private extension AddingTaskViewController {
    @objc
    private func createTaskTapped() {
        collectData()
    }
    
    private func collectData() {
        let title = titleTextField.text
        let subtitle = descriptionTextView.text
        
        viewModel.createTask(titleText: title, descriptionText: subtitle) { infoText in
            AlertManager.showAlert(message: infoText, viewController: self)
        }
    }
}

extension AddingTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isLengthLimit(textField, range, string)
    }
    
    private func isLengthLimit(_ textField: UITextField, _ range: NSRange, _ string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 10
    }
}

extension AddingTaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        isLengthLimit(textView, range, text)
    }
    
    private func isLengthLimit(_ textView: UITextView, _ range: NSRange, _ text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 60
    }
}

