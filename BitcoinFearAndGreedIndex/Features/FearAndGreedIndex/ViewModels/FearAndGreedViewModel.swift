import Foundation
import SwiftUI
import Combine

@MainActor
class FearAndGreedViewModel: ObservableObject {
  @Published var indexData: FearAndGreedData?
  @Published var isLoading = false
  @Published var error: NetworkError?
  
  private let service: CoinMarketCapService
  
  init(service: CoinMarketCapService) {
    self.service = service
  }
  
  func fetchFearAndGreedIndex() async {
    isLoading = true
    error = nil
    
    do {
      let response: FearAndGreedResponse = try await service.fetch(
        endpoint: NetworkConstants.Endpoint.FearAndGreed.latest
      )
      
      indexData = response.data
      isLoading = false
    } catch let error as NetworkError {
      self.error = error
      isLoading = false
    } catch {
      self.error = .requestFailed(error)
      isLoading = false
    }
  }
  
  func getClassification() -> IndexClassification? {
    guard let value = indexData?.indexValue else { return nil }
    
    if IndexClassification.extremeFear.range.contains(value) {
      return .extremeFear
    } else if IndexClassification.fear.range.contains(value) {
      return .fear
    } else if IndexClassification.neutral.range.contains(value) {
      return .neutral
    } else if IndexClassification.greed.range.contains(value) {
      return .greed
    } else {
      return .extremeGreed
    }
  }
  
  func formattedTimestamp() -> String {
    guard let timestamp = indexData?.timestamp else { return Strings.General.notAvailable }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Strings.DateFormat.apiDateFormat
    
    guard let date = dateFormatter.date(from: timestamp) else { return timestamp }
    
    dateFormatter.dateFormat = Strings.DateFormat.displayDateFormat
    return dateFormatter.string(from: date)
  }
}
