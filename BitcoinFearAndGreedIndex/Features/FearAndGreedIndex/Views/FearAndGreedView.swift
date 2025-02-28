import SwiftUI

struct FearAndGreedView: View {
  @StateObject private var viewModel: FearAndGreedViewModel
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.dynamicTypeSize) private var dynamicTypeSize
  
  init(apiKey: String) {
    _viewModel = StateObject(wrappedValue: FearAndGreedViewModel(service: CoinMarketCapService(apiKey: apiKey)))
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        backgroundView
        VStack(spacing: 20) {
          if viewModel.isLoading {
            loadingView
          } else if let error = viewModel.error {
            errorView(error: error)
          } else if let indexData = viewModel.indexData,
                    let classification = viewModel.getClassification() {
            dataView(indexData: indexData, classification: classification)
          } else {
            noDataView
          }
        }
        .padding()
      }
      .navigationTitle(Strings.FearAndGreed.title)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          refreshButton
        }
      }
    }
    .task {
      await viewModel.fetchFearAndGreedIndex()
    }
  }
  
  private var backgroundView: some View {
    Color(uiColor: .systemGroupedBackground)
      .ignoresSafeArea()
  }
  
  private var loadingView: some View {
    VStack {
      Spacer()
      ProgressView()
        .scaleEffect(1.5)
        .padding()
        .accessibilityLabel("Loading data")
      Spacer()
    }
    .frame(minHeight: 300)
  }
  
  private var noDataView: some View {
    VStack(spacing: 16) {
      Image(systemName: "chart.bar.xaxis")
        .font(.system(size: 50))
        .foregroundColor(.secondary)
      
      Text(Strings.General.noDataAvailable)
        .font(.title2)
        .fontWeight(.medium)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .frame(minHeight: 300)
  }
  
  private var refreshButton: some View {
    Button(action: {
      Task {
        await viewModel.fetchFearAndGreedIndex()
      }
    }) {
      Image(systemName: "arrow.clockwise")
        .accessibilityLabel("Refresh data")
    }
  }
  
  private func errorView(error: NetworkError) -> some View {
    VStack(spacing: 20) {
      Spacer()
      
      Image(systemName: "exclamationmark.triangle")
        .font(.system(size: 50))
        .foregroundColor(.orange)
        .accessibilityHidden(true)
      
      Text(Strings.Error.errorTitle)
        .font(.title2)
        .fontWeight(.bold)
      
      Text(error.message)
        .font(.body)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
        .foregroundColor(.secondary)
      
      Button(action: {
        Task {
          await viewModel.fetchFearAndGreedIndex()
        }
      }) {
        Text(Strings.Error.tryAgain)
          .fontWeight(.semibold)
          .padding(.horizontal, 24)
          .padding(.vertical, 12)
          .background(Color.accentColor)
          .foregroundColor(Color(uiColor: .systemBackground))
          .cornerRadius(10)
      }
      .padding(.top, 8)
      
      Spacer()
    }
    .frame(minHeight: 300)
    .accessibilityElement(children: .combine)
    .accessibilityLabel("Error: \(error.message)")
    .accessibilityAddTraits(.isButton)
    .accessibilityHint("Double tap to try again")
  }
  
  private func dataView(indexData: FearAndGreedData, classification: IndexClassification) -> some View {
    VStack(spacing: dynamicTypeSize > .large ? 16 : 30) {
      Spacer()
      
      GaugeView(
        value: Double(indexData.indexValue),
        classification: classification
      )
      .padding(.bottom, dynamicTypeSize > .large ? 0 : 10)
      
      Spacer()
      
      infoCard(indexData: indexData, classification: classification)
      
      Text(Strings.FearAndGreed.description)
        .font(.footnote)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal)
    }
  }
  
  private func infoCard(indexData: FearAndGreedData, classification: IndexClassification) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text(classification.emoji)
          .font(.title)
        Text(classification.rawValue)
          .font(.title)
          .bold()
          .foregroundColor(classification.color)
      }
      .frame(maxWidth: .infinity, alignment: .center)
      .padding(.bottom, 4)
      
      Text(classification.description)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 8)
      
      Divider()
      
      InfoRow(title: Strings.FearAndGreed.lastUpdated, value: viewModel.formattedTimestamp())
    }
    .padding()
    .background(Color(uiColor: .secondarySystemGroupedBackground))
    .cornerRadius(12)
    .shadow(color: Color(uiColor: .label).opacity(0.05), radius: 5)
  }
}

#Preview("Light Mode") {
  FearAndGreedView(apiKey: "test-api-key")
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
  FearAndGreedView(apiKey: "test-api-key")
    .preferredColorScheme(.dark)
}
