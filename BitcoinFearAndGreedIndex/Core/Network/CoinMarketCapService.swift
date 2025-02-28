import Foundation

class CoinMarketCapService {
  private let baseURL: String
  private let apiKey: String
  private let session: URLSession
  
  init(
    baseURL: String = NetworkConstants.BaseURL.coinMarketCap,
    apiKey: String,
    session: URLSession = .shared
  ) {
    self.baseURL = baseURL
    self.apiKey = apiKey
    self.session = session
  }
  
  func fetch<T: Decodable>(
    endpoint: String,
    parameters: [String: String] = [:]
  ) async throws -> T {
    var components = URLComponents(string: baseURL + endpoint)
    
    if !parameters.isEmpty {
      components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    guard let url = components?.url else {
      throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.addValue(apiKey, forHTTPHeaderField: NetworkConstants.Header.apiKey)
    request.addValue(NetworkConstants.ContentType.json, forHTTPHeaderField: NetworkConstants.Header.accept)
    
    let (data, response) = try await session.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.invalidResponse
    }
    
    switch httpResponse.statusCode {
    case 200...299:
      do {
        return try JSONDecoder().decode(T.self, from: data)
      } catch {
        throw NetworkError.decodingFailed(error)
      }
    case 401:
      throw NetworkError.unauthorized
    default:
      throw NetworkError.serverError(statusCode: httpResponse.statusCode)
    }
  }
}
