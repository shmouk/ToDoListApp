import UIKit

class TaskHeaderView: UITableViewHeaderFooterView {
    var customTitleLabel = InterfaceBuilder.makeLabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setSubviews()
        setViewAppearance()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setSubviews()
        setViewAppearance()
        setupConstraints()
    }
    
    func configure(with text: String) {
        customTitleLabel.text = text
    }
    
    private func setSubviews() {
        addSubview(customTitleLabel)
    }
    
    private func setViewAppearance() {
        contentView.backgroundColor = .bg
        customTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            customTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            customTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            customTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
