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
        tableView.register(TaskHeaderView.self, forHeaderFooterViewReuseIdentifier: TaskHeaderView.description())
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
        updateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rows = tableView.numberOfRows(inSection: indexPath.section)

        RoundedCellDecorator.roundCorners(at: indexPath, totalRows: rows, for: cell, cornerRadius: 16.0)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        deleteSwipeConfig(at: indexPath)
    }

    private func deleteSwipeConfig(at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let filterAction = UIContextualAction(style: .normal, title: Constants.deleteTitle) { [weak self] (action, view, bool) in
            self?.updateCell(at: indexPath)
            bool(true)
        }
        filterAction.image = InterfaceBuilder.makeDeleteImage()
        filterAction.backgroundColor = .bg
//        filterAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [filterAction])
    }
    
    private func updateCell(at indexPath: IndexPath) {
        AlertManager.showConfirmationAlert(message: Constants.isCompleteTitle, viewController: self) { [weak self] in
            guard let self = self else { return }
            let task = self.dataSource.taskData[indexPath.section][indexPath.row]
            self.viewModel.updateTask(task) { _ in
                self.tableView.reloadData()
            }
        }
    }
}

extension TasksTableViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskHeaderView.description()) as? TaskHeaderView
        let taskHeaderTitle = [Constants.curentTitle, Constants.completedTitle]
        headerView?.configure(with: taskHeaderTitle[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        42
    }
}


