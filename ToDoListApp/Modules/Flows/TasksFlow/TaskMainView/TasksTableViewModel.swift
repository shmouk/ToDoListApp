import Foundation
 
class TasksTableViewModel {
    let taskAPI = TaskAPI.shared
    var taskData = Bindable([[TaskModel]]())

    func readTask() {
        taskAPI.taskData.bind { [weak self] data in
            guard let self = self else { return }
            self.sortData(data)
        }
    }
    
    private func sortData(_ data: [TaskModel]) {
        var readyTaskData = [TaskModel]()
        var currentTaskData = [TaskModel]()
        
        for task in data {
            task.isReady ? readyTaskData.append(task) : currentTaskData.append(task)
        }
        taskData.value = [currentTaskData, readyTaskData]
    }
    
    func updateTask(_ data: TaskModel, completion: @escaping (String) -> Void) {
        let completionHandler: ResultCompletion = { [weak self] result in
            self?.handleResult(result, completion)
        }
        
        if data.isReady {
            taskAPI.removeData(data, completion: completionHandler)
        } else {
            taskAPI.updateValue(data, completion: completionHandler)
        }
    }

    private func handleResult(_ result: RequestResult, _ completion: @escaping (String) -> Void) {
        switch result {
        case .success(let text):
            readTask()
            completion(text.info)
            
        case .failure(let error):
            completion(error.localizedDescription)
        }
    }
}
