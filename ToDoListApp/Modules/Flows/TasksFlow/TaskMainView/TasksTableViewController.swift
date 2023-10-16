import UIKit
import RealmSwift

class TasksTableViewController: BaseViewController {
    private let viewModel = TasksTableViewModel()
    private let dataSource = TaskDataSource()

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
        tableView.separatorStyle = .none
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.description())
        tableView.register(TaskHeaderView.self, forHeaderFooterViewReuseIdentifier: TaskHeaderView.description())
    }
    
    private func setSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupResponsibilities() {
        self.navigationItem.title = DefaultText.taskList
        self.navigationItem.rightBarButtonItem = rightNavButton
        rightNavButton.target = self
        rightNavButton.action = #selector(addTaskTapped)
    }
    
    private func loadData() {
        viewModel.readTask()
    }
    
    private func bindViewModel() {
        viewModel.taskData.bind { [weak self] data in
            guard let self = self else { return }
            self.dataSource.taskData = data
            self.reloadTable()
        }
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateCell(at: indexPath, needsConfirmation: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.customTableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        deleteSwipeConfig(at: indexPath)
    }

    private func deleteSwipeConfig(at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let filterAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, bool) in
            self?.updateCell(at: indexPath, needsConfirmation: false)
            bool(true)
        }
    
        filterAction.image = InterfaceBuilder.makeDeleteImage()
        filterAction.backgroundColor = .bg
        return UISwipeActionsConfiguration(actions: [filterAction])
    }
    
    private func updateCell(at indexPath: IndexPath, needsConfirmation: Bool) {
        let task = dataSource.taskData[indexPath.section][indexPath.row]
        
        let updateCompletionHandler: (String) -> Void = { [weak self] text in
            guard let self = self else { return }
            
            AlertManager.showAlert(title: text, viewController: self)
            self.reloadTable()
        }
        
        guard needsConfirmation else {
            viewModel.updateTask(task, completion: updateCompletionHandler)
            return
        }

        AlertManager.showConfirmationAlert(message: DefaultText.isComplete, viewController: self) { [weak self] in
            self?.viewModel.updateTask(task, completion: updateCompletionHandler)
        }
    }
}

extension TasksTableViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskHeaderView.description()) as? TaskHeaderView
        let taskHeaderTitle = [DefaultText.current, DefaultText.complete]
        headerView?.configure(with: taskHeaderTitle[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        42
    }
}

