import Foundation

struct FearAndGreedResponse: Decodable {
  let data: FearAndGreedData
  let status: FearAndGreedStatus
}

struct FearAndGreedStatus: Decodable {
  let timestamp: String
  let errorCode: String
  let errorMessage: String
  let elapsed: Int
  let creditCount: Int
  
  enum CodingKeys: String, CodingKey {
    case timestamp
    case errorCode = "error_code"
    case errorMessage = "error_message"
    case elapsed
    case creditCount = "credit_count"
  }
}

struct FearAndGreedData: Decodable {
  let indexValue: Int
  let classification: String
  let timestamp: String
  
  enum CodingKeys: String, CodingKey {
    case indexValue = "value"
    case classification = "value_classification"
    case timestamp = "update_time"
  }
}
