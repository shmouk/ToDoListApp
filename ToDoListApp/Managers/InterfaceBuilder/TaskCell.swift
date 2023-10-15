import UIKit

class TaskCell : UITableViewCell {
    lazy var titleLabel = InterfaceBuilder.makeLabel()
    lazy var subtitleLabel = InterfaceBuilder.makeLabel()
    lazy var readinessElipseView = InterfaceBuilder.makeElipseView()
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setAsSelectedOrHighlighted(selectedOrHighlighted: highlighted, animated: animated)
        super.setHighlighted(highlighted, animated: animated)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        setAsSelectedOrHighlighted(selectedOrHighlighted: selected, animated: animated)
//        super.setSelected(selected, animated: animated)
//    }

    func setAsSelectedOrHighlighted(selectedOrHighlighted: Bool, animated: Bool) {
        let backgroundColor = selectedOrHighlighted ? UIColor.white : UIColor.clear

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
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setSubviews()
        setupConstraints()
    }
    
    func configure(with task: TaskModel) {
        titleLabel.text = "Title: " + task.title
        subtitleLabel.text = "Subtitle: " + task.subTitle
        readinessElipseView.backgroundColor = task.isReady ? .green : .red
    }
    
    private func setSubviews() {
        selectionStyle = .none
        backgroundColor = .other
        addSubviews(readinessElipseView, titleLabel, subtitleLabel)
    }
       
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            readinessElipseView.centerYAnchor.constraint(equalTo: centerYAnchor),
            readinessElipseView.heightAnchor.constraint(equalTo: heightAnchor),
            readinessElipseView.widthAnchor.constraint(equalTo: readinessElipseView.heightAnchor),
            readinessElipseView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: readinessElipseView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: readinessElipseView.trailingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


