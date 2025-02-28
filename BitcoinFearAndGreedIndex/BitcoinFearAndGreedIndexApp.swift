//
//  BitcoinFearAndGreedIndexApp.swift
//  BitcoinFearAndGreedIndex
//
//  Created by Ainan Ameen on 2025-02-27.
//

import SwiftUI

@main
struct BitcoinFearAndGreedIndexApp: App {
  var body: some Scene {
    WindowGroup {
      FearAndGreedView(
        apiKey: "c7c0cbda-59dc-47ef-8036-3a478c3c41ce"
      )
      .accentColor(Color.blue)
    }
  }
}
