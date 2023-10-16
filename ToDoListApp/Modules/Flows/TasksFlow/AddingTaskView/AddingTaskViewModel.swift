import Foundation

class AddingTaskViewModel {
    let taskAPI = TaskAPI.shared
    
    func createTask(titleText: String?, descriptionText: String?, completion: @escaping (String) -> Void) {
        guard titleText != "",
              descriptionText != DefaultText.inputText,
              descriptionText != "",
              descriptionText != " ",
              let titleText = titleText,
              let descriptionText = descriptionText else {
            completion(RequestError.invalidText.info)
            return
        }
        
        taskAPI.writeData(titleText, descriptionText) { result in
            switch result {
            case .success(let text):
                completion(text.info)
                
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}
