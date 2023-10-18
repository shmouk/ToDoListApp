import UIKit

final class InterfaceBuilder {
    static func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
    
    static func makeLabel(title: String? = nil, textColor: UIColor? = UIColor(named: "TintColor")) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.text = title
        return label
    }
    
    static func makeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func makeSeparatorView(alpha: CGFloat = 0.2) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .other.withAlphaComponent(alpha)
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = false
        return view
    }
    
    static func makeDeleteImage() -> UIImage? {
        .init(named: "DeleteIcon")
    }
    
    static func makeCustomNavBarButton() -> UIBarButtonItem {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.tintColor = UIColor(named: "TintColor")
        return button
    }
    
    static func makeButton(withTitle: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(withTitle, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "TintColor")
        return button
    }
    
    static func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.borderStyle = .line
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderColor = UIColor(named: "OtherColor")?.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        let placeholderText = "inputText".localized
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        let leftPaddingView = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 48))
        leftPaddingView.isUserInteractionEnabled = false
        leftPaddingView.backgroundColor = .clear
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }
    
    static func makeTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.layer.borderColor = UIColor(named: "OtherColor")?.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 16
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.text = "inputText".localized
        textView.isScrollEnabled = false
        textView.layer.masksToBounds = true
        textView.isEditable = true
        return textView
    }
}

