import Foundation
import RealmSwift

class TaskAPI {
    static let shared = TaskAPI()

    private var notificationToken: NotificationToken?

    var taskData = Bindable([TaskModel]())

    private init() {
        startObserve()
    }
    
    deinit {
        notificationToken?.invalidate()
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
    
    private func startObserve() {
        do {
            let realm = try Realm()
            let objects = realm.objects(TaskModel.self)
            
            notificationToken = objects.observe { [weak self] changes in
                guard let self = self else { return }
                
                switch changes {
                case .initial(let data):
                    taskData.value = Array(data)
                    
                case .update(let data, _, _, _):
                    taskData.value = Array(data)
                    
                case .error(let error):
                    print(error)
                }
            }
        } catch {
            print(RequestError.invalidRequest.info)
        }
    }
    
    func updateValue(_ data: TaskModel, completion: @escaping ResultCompletion) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                let tasks = realm.objects(TaskModel.self)
                guard let task = tasks.filter("id == %@", data.id).first else {
                    completion(.failure(RequestError.updateValueError))
                    return
                }
                
                try realm.write {
                    task.isReady = true
                    completion(.success(RequestComplete.successUpdate))
                }
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
    }
    
    func removeData(_ data: TaskModel, completion: @escaping ResultCompletion) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                let objectToDelete = realm.objects(TaskModel.self).filter("id == %@", data.id).first

                guard let object = objectToDelete else {
                    completion(.failure(RequestError.deleteError))
                    return
                }
                try realm.write {
                    realm.delete(object)
                    completion(.success(RequestComplete.successUpdate))
                }
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
    }
    
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



