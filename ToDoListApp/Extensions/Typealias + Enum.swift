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
            return DefaultText.invalidText
            
        case .invalidRequest:
            return DefaultText.invalidRequest
            
        case .updateValueError:
            return DefaultText.updateValueError
            
        case .deleteError:
            return DefaultText.deleteError
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
            return DefaultText.successUpload
            
        case .successDownload:
            return DefaultText.successUpload
         
        case .successUpdate:
            return DefaultText.successUpdate
        }
    }
}
