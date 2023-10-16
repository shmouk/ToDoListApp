typealias ResultCompletion = (Result<RequestComplete, Error>) -> Void
typealias RequestResult = Result<RequestComplete, Error>
typealias TaskCompletion = (Result<TaskModel, Error>) -> Void

enum RequestError: Error {
    case invalidText
    case invalidRequest
    case updateValueError
    case deleteError

    var info: String {
        switch self {
            
        case .invalidText:
            return Constants.invalidText
            
        case .invalidRequest:
            return Constants.invalidRequest
            
        case .updateValueError:
            return Constants.updateValueError
            
        case .deleteError:
            return Constants.deleteError
        }
    }
}

enum RequestComplete {
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
