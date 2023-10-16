import UIKit

class TaskCell : UITableViewCell {
    lazy var titleLabel = InterfaceBuilder.makeLabel()
    lazy var subtitleLabel = InterfaceBuilder.makeLabel()
    lazy var customBackgroundView = InterfaceBuilder.makeView()
    lazy var separatorView = InterfaceBuilder.makeSeparatorView()

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setAsSelectedOrHighlighted(selectedOrHighlighted: highlighted, animated: animated)
        super.setHighlighted(highlighted, animated: animated)
    }

    func setAsSelectedOrHighlighted(selectedOrHighlighted: Bool, animated: Bool) {
        let backgroundColor = selectedOrHighlighted ? UIColor.white.withAlphaComponent(0.2) : UIColor.clear

        let action = {
            self.contentView.backgroundColor = backgroundColor
        }

        if animated {
            UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseInOut, animations: action, completion: nil)
        } else {
            action()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setSubviews()
    }
    
    func configure(with task: TaskModel) {
        titleLabel.text = "Title: " + task.title
        subtitleLabel.text = "Subtitle: " + task.subTitle
        customBackgroundView.backgroundColor = task.isReady ? .green.withAlphaComponent(0.2) : .red.withAlphaComponent(0.3)
        setupConstraints()
    }
    
    private func setSubviews() {
        selectionStyle = .none
        backgroundColor = .white
        addSubview(customBackgroundView)
        customBackgroundView.addSubviews(titleLabel,
                    subtitleLabel,
                    separatorView)
    }
       
    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 64)
//        ])
        
        NSLayoutConstraint.activate([
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -24),
            subtitleLabel.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}


