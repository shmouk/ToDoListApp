import Foundation
import RealmSwift

class TaskAPI {
    let notificationCenterManager = NotificationCenterManager.shared
    
    var readyTaskData = [TaskModel]() {
       didSet {
           print("1. modddiiiiiiffyyyyy")
           notificationCenterManager.postCustomNotification(named: .modifyDataNotification)
       }
   }
    var currentTaskData = [TaskModel]() {
        didSet {
            print("2. modddiiiiiiffyyyyy")
            notificationCenterManager.postCustomNotification(named: .modifyDataNotification)
        }
    }
    
    func writeData(_ titleText: String, _ descriptionText: String, completion: @escaping ResultCompletion) {
        let task: TaskModel = {
            var task = TaskModel()
            task.title = titleText
            task.subTitle = descriptionText
            task.isReady = false
            task.id = self.randomString(withLength: 10)
            return task
        }()
        
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(task)
                }
                
                completion(.success(RequestComplete.successUpload))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
    }
    
    
    func readData(completion: @escaping ResultCompletion) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                let data = realm.objects(TaskModel.self)
                for task in data {
                    task.isReady ? self.readyTaskData.append(task) : self.currentTaskData.append(task)
                }
                print("tasks", self.readyTaskData.count, self.currentTaskData.count)

                completion(.success(RequestComplete.successDownload))

            } catch let error as NSError {
                completion(.failure(error))
            }
        }
    }
    
    func updateValue(_ data: TaskModel, completion: @escaping ResultCompletion) {
        DispatchQueue.main.async { [weak self] in
            do {
                let realm = try Realm()
                let tasks = realm.objects(TaskModel.self)
                guard let task = tasks.filter("id == %@", data.id).first else {
                    completion(.failure(RequestError.updateValueError))
                    return
                }
                
                try realm.write {
                    task.isReady = true
                    self?.modifyValue(task)
                    completion(.success(RequestComplete.successUpdate))
                }
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
    }
    
    func modifyValue(_ task: TaskModel) {
        currentTaskData.removeAll(where: { $0.id == task.id })
        readyTaskData.append(task)
    }
    
//    func removeData(_ data: TaskModel, completion: @escaping ResultCompletion) {
//        DispatchQueue.main.async {
//            do {
//                let realm = try Realm()
//                let objectToDelete = realm.objects(TaskModel.self).filter("id == %@", data.id).first
//                
//                guard let object = objectToDelete else {
//                    completion(.failure(RequestError.deleteError))
//                    return
//                }
//                try realm.write {
//                    realm.delete(object)
//                    completion(.success(RequestComplete.successDownload))
//
//                }
//            } catch let error as NSError {
//                completion(.failure(error))
//            }
//        }
//    }
    
    private func randomString(withLength length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*()_-"
        var randomString = ""
        
        for _ in 0..<length {
            let randomIndex = Int(arc4random_uniform(UInt32(letters.count)))
            let randomChar = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            randomString.append(randomChar)
        }
        
        return randomString
    }
}



