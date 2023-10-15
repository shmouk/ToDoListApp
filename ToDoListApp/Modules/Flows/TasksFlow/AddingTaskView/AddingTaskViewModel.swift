import Foundation

class AddingTaskViewModel {
    let taskAPI = TaskAPI()
    
    func createTask(titleText: String?, descriptionText: String?, completion: @escaping (String) -> Void) {
        guard let titleText = titleText else {
            completion(RequestError.invalidText.info)
            return
        }
        
        guard let descriptionText = descriptionText,
              descriptionText != "Input text" else {
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
