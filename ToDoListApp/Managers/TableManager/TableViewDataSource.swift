import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    var taskData = [TaskModel]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.description(), for: indexPath) as? TaskCell else { return UITableViewCell() }
        let item = taskData[indexPath.row]
        cell.configure(with: item)
        cell.isSelected = false
        return cell
    }

}
