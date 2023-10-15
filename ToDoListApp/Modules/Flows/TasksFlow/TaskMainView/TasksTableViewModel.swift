import Foundation
 
class TasksTableViewModel {
    let taskAPI = TaskAPI()
    var taskData = Bindable([[TaskModel](), [TaskModel]()])
    
    init() {
        taskAPI.notificationCenterManager.addObserver(self, selector: #selector(modifyDataHandle), forNotification: .modifyDataNotification)

    }
    
    deinit {
        taskAPI.notificationCenterManager.removeObserver(self, forNotification: .modifyDataNotification)

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
    
    func updateTask(_ data: TaskModel, completion: @escaping (String) -> Void) {
        taskAPI.updateValue(data) { result in
            switch result {
                
            case .success(let text):
                completion(text.info)
                self.setValue()
                
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
    private func setValue() {
        taskData.value[0] = taskAPI.currentTaskData
        taskData.value[1] = taskAPI.readyTaskData
    }
}

extension TasksTableViewModel {
    @objc
    func modifyDataHandle() {
        setValue()
    }
}
