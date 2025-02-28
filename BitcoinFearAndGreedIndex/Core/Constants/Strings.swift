import Foundation

enum Strings {
  // General
  enum General {
    static let appName = "Bitcoin Fear & Greed Index"
    static let notAvailable = "N/A"
    static let noDataAvailable = "No data available"
  }
  
  // Error Messages
  enum Error {
    static let errorTitle = "Error"
    static let tryAgain = "Try Again"
    static let invalidURL = "Invalid URL"
    static let invalidResponse = "Invalid response from server"
    static let unauthorized = "API key is invalid or missing"
    static let requestFailedFormat = "Request failed: %@"
    static let decodingFailedFormat = "Failed to decode data: %@"
    static let serverErrorFormat = "Server error with status code: %d"
  }
  
  // Fear and Greed View
  enum FearAndGreed {
    static let title = "BTC Fear & Greed Index"
    static let lastUpdated = "Last Updated"
    static let description = "The Fear & Greed Index is a tool designed to analyze emotions and sentiments from different sources and compute a Bitcoin and crypto market sentiment value."
    
    // Classifications
    static let extremeFear = "Extreme Fear"
    static let fear = "Fear"
    static let neutral = "Neutral"
    static let greed = "Greed"
    static let extremeGreed = "Extreme Greed"
  }
  
  // Date Formats
  enum DateFormat {
    static let apiDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let displayDateFormat = "MMM d, yyyy h:mm a"
  }
} 
