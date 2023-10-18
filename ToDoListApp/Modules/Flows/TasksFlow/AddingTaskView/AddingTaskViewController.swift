import UIKit

class AddingTaskViewController: BaseViewController {
    private let viewModel: AddingTaskViewModel
    
    private let alertManager = AlertManager.shared
    
    lazy var titleTextField = InterfaceBuilder.makeTextField()
    lazy var descriptionTextView = InterfaceBuilder.makeTextView()
    lazy var createTaskButton = InterfaceBuilder.makeButton(withTitle: "createTask".localized)
    lazy var titleLabel = InterfaceBuilder.makeLabel(title: "title".localized)
    lazy var subtitleLabel = InterfaceBuilder.makeLabel(title: "subtitle".localized)
    lazy var separatorView = InterfaceBuilder.makeSeparatorView(alpha: 0.4)
    
    init(viewModel: AddingTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        KeyboardNotificationManager.hideKeyboard()
    }
    
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
                         createTaskButton,
                         separatorView)
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
        
        viewModel.createTask(titleText: title, descriptionText: subtitle) { [weak self] infoText in
            guard let self = self else { return }
            
            alertManager.showAlert(title: infoText, viewController: self)
            self.titleTextField.text = nil
            self.descriptionTextView.text = "inputText".localized
        }
    }
}

extension AddingTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return isLengthLimit(textField, range, string) && !isStartsWithEmptyLine(textField, range, string)
    }

    private func isLengthLimit(_ textField: UITextField, _ range: NSRange, _ string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.count + string.count - range.length
        return newLength <= 10
    }

    private func isStartsWithEmptyLine(_ textField: UITextField, _ range: NSRange, _ string: String) -> Bool {
        guard let currentText = textField.text,
              let textRange = Range(range, in: currentText) else {
            return true
        }
        
        let newText = currentText.replacingCharacters(in: textRange, with: string)
        let trimmedText = newText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedText.isEmpty && !newText.isEmpty {
            textField.text = ""
            return true
        }
        
        return false
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
        return newText.count <= 80
    }
}

