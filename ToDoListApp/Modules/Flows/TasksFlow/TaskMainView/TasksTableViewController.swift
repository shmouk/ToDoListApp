import UIKit
import RealmSwift

class TasksTableViewController: BaseViewController {
    private let dataSource = TableViewDataSource()
    private let viewModel = TasksTableViewModel()
    
    var coordinator: CoordinatorProtocol?
    
    lazy var tableView = InterfaceBuilder.makeTableView()
    lazy var rightNavButton = InterfaceBuilder.makeCustomNavBarButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupResponsibilities()
        bindViewModel()
    }
    
    private func setUI() {
        setSubviews()
        settingTableView()
        setupConstraints()
    }
    
    private func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.description())
    }
    
    private func setSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupResponsibilities() {
        self.navigationItem.rightBarButtonItem = rightNavButton
        rightNavButton.target = self
        rightNavButton.action = #selector(addTaskTapped)
    }
    
    private func loadData() {
        viewModel.readTask { infoText in
            AlertManager.showAlert(message: infoText, viewController: self)
        }
    }
    
    private func bindViewModel() {
        viewModel.taskData.bind { [weak self] data in
            guard let self = self else { return }
            dataSource.taskData = data
            tableView.reloadData()
        }
    }
}

private extension TasksTableViewController {
    @objc
    private func addTaskTapped() {
        coordinator?.presentAddedTaskViewController()
    }
}

extension TasksTableViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.description(), for: indexPath) as? TaskCell else { return }
//        cell.backgroundColor = .tint
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deleteCell(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rows = tableView.numberOfRows(inSection: indexPath.section)
        
//        if indexPath.row == 0 {
//            orientation = [.topLeft, .topRight]
//        }
//        if indexPath.row == totalRows - 1 {
//            orientation = [.bottomLeft, .bottomRight]
//        }
//        if totalRows == 1 {
//            orientation = [.allCorners]
//        }
        RoundedCellDecorator.roundCorners(count: rows, for: cell, cornerRadius: 16.0)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        deleteSwipeConfig(at: indexPath)
    }

    private func deleteSwipeConfig(at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let filterAction = UIContextualAction(style: .destructive, title: Constants.deleteTitle) { [weak self] (action, view, bool) in
            self?.deleteCell(at: indexPath.row)
            bool(true)
        }
        
        filterAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [filterAction])
    }
    
    private func deleteCell(at row: Int) {
        AlertManager.showConfirmationAlert(message: Constants.isComplete, viewController: self) { [weak self] in
            guard let self = self else { return }
            let task = self.dataSource.taskData[row]
            self.viewModel.deleteTask(task) { _ in
                self.tableView.reloadData()
            }
        }
    }
}



