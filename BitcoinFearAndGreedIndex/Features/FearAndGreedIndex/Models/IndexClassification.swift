import Foundation
import SwiftUI

enum IndexClassification: String {
  case extremeFear = "Extreme Fear"
  case fear = "Fear"
  case neutral = "Neutral"
  case greed = "Greed"
  case extremeGreed = "Extreme Greed"
  
  init?(rawValue: String) {
    switch rawValue {
    case Strings.FearAndGreed.extremeFear: self = .extremeFear
    case Strings.FearAndGreed.fear: self = .fear
    case Strings.FearAndGreed.neutral: self = .neutral
    case Strings.FearAndGreed.greed: self = .greed
    case Strings.FearAndGreed.extremeGreed: self = .extremeGreed
    default: return nil
    }
  }
  
  var rawValue: String {
    switch self {
    case .extremeFear: return Strings.FearAndGreed.extremeFear
    case .fear: return Strings.FearAndGreed.fear
    case .neutral: return Strings.FearAndGreed.neutral
    case .greed: return Strings.FearAndGreed.greed
    case .extremeGreed: return Strings.FearAndGreed.extremeGreed
    }
  }
  
  var color: Color {
    switch self {
    case .extremeFear: return .red
    case .fear: return .orange
    case .neutral: return .yellow
    case .greed: return .mint
    case .extremeGreed: return .green
    }
  }
  
  var emoji: String {
    switch self {
    case .extremeFear: return "😱"
    case .fear: return "😨"
    case .neutral: return "😐"
    case .greed: return "🤑"
    case .extremeGreed: return "🚀"
    }
  }
  
  var description: String {
    switch self {
    case .extremeFear: 
      return "Investors are in panic mode. This could be a buying opportunity."
    case .fear: 
      return "Market sentiment is cautious. Investors are worried about the future."
    case .neutral: 
      return "The market is balanced between fear and greed. No strong sentiment either way."
    case .greed: 
      return "Investors are getting excited. The market might be overheating."
    case .extremeGreed: 
      return "Investors are extremely optimistic. The market might be due for a correction."
    }
  }
  
  var range: ClosedRange<Int> {
    switch self {
    case .extremeFear: return 0...19
    case .fear: return 20...39
    case .neutral: return 40...59
    case .greed: return 60...79
    case .extremeGreed: return 80...100
    }
  }
} 