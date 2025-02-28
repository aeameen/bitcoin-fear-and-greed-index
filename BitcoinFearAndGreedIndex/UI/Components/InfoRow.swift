import SwiftUI

struct InfoRow: View {
  let title: String
  let value: String
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(title)
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundColor(.secondary)
      Spacer()
      Text(value)
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundColor(.primary)
        .multilineTextAlignment(.trailing)
    }
    .accessibilityElement(children: .combine)
    .accessibilityLabel("\(title), \(value)")
  }
}

// MARK: - Previews
#Preview("Light Mode") {
  VStack {
    InfoRow(title: "Last Updated", value: "Mar 15, 2023 4:30 PM")
    InfoRow(title: "Value", value: "65")
    InfoRow(title: "Classification", value: "Greed")
  }
  .padding()
  .background(Color(uiColor: .systemBackground))
  .cornerRadius(12)
  .shadow(color: Color.black.opacity(0.1), radius: 5)
  .padding()
  .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
  VStack {
    InfoRow(title: "Last Updated", value: "Mar 15, 2023 4:30 PM")
    InfoRow(title: "Value", value: "65")
    InfoRow(title: "Classification", value: "Greed")
  }
  .padding()
  .background(Color(uiColor: .secondarySystemBackground))
  .cornerRadius(12)
  .shadow(color: Color.black.opacity(0.2), radius: 5)
  .padding()
  .preferredColorScheme(.dark)
} 