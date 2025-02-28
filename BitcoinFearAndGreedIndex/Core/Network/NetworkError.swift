import Foundation

enum NetworkError: Error {
  case invalidURL
  case requestFailed(Error)
  case invalidResponse
  case decodingFailed(Error)
  case serverError(statusCode: Int)
  case unauthorized
  
  var message: String {
    switch self {
    case .invalidURL:
      return Strings.Error.invalidURL
    case .requestFailed(let error):
      return String(format: Strings.Error.requestFailedFormat, error.localizedDescription)
    case .invalidResponse:
      return Strings.Error.invalidResponse
    case .decodingFailed(let error):
      return String(format: Strings.Error.decodingFailedFormat, error.localizedDescription)
    case .serverError(let code):
      return String(format: Strings.Error.serverErrorFormat, code)
    case .unauthorized:
      return Strings.Error.unauthorized
    }
  }
}
