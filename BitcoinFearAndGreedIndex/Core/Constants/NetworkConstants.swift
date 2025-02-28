import Foundation

enum NetworkConstants {
  // Base URLs
  enum BaseURL {
    static let coinMarketCap = "https://pro-api.coinmarketcap.com/v3"
  }
  
  // Endpoints
  enum Endpoint {
    // Fear and Greed
    enum FearAndGreed {
      static let latest = "/fear-and-greed/latest"
    }
  }
  
  // Headers
  enum Header {
    static let apiKey = "X-CMC_PRO_API_KEY"
    static let accept = "Accept"
    static let contentType = "Content-Type"
  }
  
  // Content Types
  enum ContentType {
    static let json = "application/json"
  }
}
