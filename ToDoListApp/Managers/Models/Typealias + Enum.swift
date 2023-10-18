import Foundation

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
            return "invalidText".localized
            
        case .invalidRequest:
            return "invalidRequest".localized
            
        case .updateValueError:
            return "updateValueError".localized
            
        case .deleteError:
            return "deleteError".localized
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
            return "successUpload".localized
            
        case .successDownload:
            return "successUpload".localized
         
        case .successUpdate:
            return "successUpdate".localized
        }
    }
}
