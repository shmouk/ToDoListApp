import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    var taskData = [[TaskModel](), [TaskModel]()]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskData[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.description(), for: indexPath) as? TaskCell else { return UITableViewCell() }
        let section = indexPath.section
        let row = indexPath.row
        let task = taskData[section][row]
        cell.configure(with: task)
        cell.isSelected = false
        return cell
    }
}
