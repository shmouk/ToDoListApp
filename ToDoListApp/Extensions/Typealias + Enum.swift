typealias ResultCompletion = (Result<RequestComplete, Error>) -> Void

enum RequestError: Error {
    case invalidText
    case invalidRequest
    case deleteError
    
    var info: String {
        switch self {
            
        case .invalidText:
            return Constants.invalidText
            
        case .invalidRequest:
            return Constants.invalidRequest
            
        case .deleteError:
            return Constants.deleteError
        }
    }
}

enum RequestComplete: String {
    case successUpload
    case successDownload
    
    var info: String {
        switch self {
            
        case .successUpload:
            return Constants.successUpload
            
        case .successDownload:
            return Constants.successUpload
            
        }
    }
}
