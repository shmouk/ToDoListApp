typealias ResultCompletion = (Result<RequestComplete, Error>) -> Void
typealias TaskCompletion = (Result<TaskModel, Error>) -> Void

enum RequestError: Error {
    case invalidText
    case invalidRequest
    case updateValueError
    
    var info: String {
        switch self {
            
        case .invalidText:
            return Constants.invalidText
            
        case .invalidRequest:
            return Constants.invalidRequest
            
        case .updateValueError:
            return Constants.updateValueError
        }
    }
}

enum RequestComplete: String {
    case successUpload
    case successDownload
    case successUpdate
    
    var info: String {
        switch self {
            
        case .successUpload:
            return Constants.successUpload
            
        case .successDownload:
            return Constants.successUpload
         
        case .successUpdate:
            return Constants.successUpdate
        }
    }
}
