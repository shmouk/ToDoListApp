import Foundation
 
class TasksTableViewModel {
    let taskAPI = TaskAPI()
    var taskData = Bindable([TaskModel]())
    
    init() {
        taskAPI.notificationCenterManager.addObserver(self, selector: #selector(newDataHandle), forNotification: .loadDataNotification)
    }
    
    deinit {
        taskAPI.notificationCenterManager.removeObserver(self, forNotification: .loadDataNotification)
    }
    
    func readTask(completion: @escaping (String) -> Void) {
        taskAPI.readData { [weak self] result in
            switch result {
                
            case .success(let text):
                completion(text.info)
                self?.setValue()
                
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    func deleteTask(_ data: TaskModel, completion: @escaping (String) -> Void) {
        taskAPI.removeData(data) { result in
            switch result {
                
            case .success(let text):
                completion(text.info)
                
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
    private func setValue() {
        taskData.value = taskAPI.taskData
    }
}

extension TasksTableViewModel {
    @objc
    func newDataHandle() {
        setValue()
    }
}
