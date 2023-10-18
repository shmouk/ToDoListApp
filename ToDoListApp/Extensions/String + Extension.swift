import Foundation

enum LocalizationManager {
  static func localizedString(_ key: String, comment: String = "") -> String {
    return NSLocalizedString(key, comment: comment)
  }
}

extension String {
  var localized: String {
    return LocalizationManager.localizedString(self)
  }
}
