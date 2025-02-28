import SwiftUI

struct GaugeView: View {
  let value: Double
  let classification: IndexClassification
  
  var body: some View {
    VStack {
      ZStack {
        // Semi-circle background
        Arc(startAngle: .degrees(180), endAngle: .degrees(0))
          .stroke(
            LinearGradient(
              gradient: Gradient(
                colors: [
                  Color.red,
                  Color.orange,
                  Color.yellow,
                  Color.mint,
                  Color.green
                ]
              ),
              startPoint: .leading,
              endPoint: .trailing
            ),
            style: StrokeStyle(lineWidth: 40, lineCap: .round)
          )
          .frame(width: 250, height: 125)
          .accessibilityHidden(true)
        
        // Value text inside the arc
        VStack(spacing: 0) {
          Text("\(Int(value))")
            .font(.system(size: 48, weight: .bold, design: .rounded))
            .foregroundColor(classification.color)
            .offset(y: 30)
        }
        .accessibilityHidden(true)
        
        // Indicator positioned on the arc
        IndicatorPoint(angle: valueToAngle(value), radius: 125)
          .frame(width: 250, height: 125)
          .accessibilityHidden(true)
      }
      .frame(height: 150)
    }
    .padding()
    .accessibilityElement(children: .combine)
    .accessibilityLabel("Fear and Greed Index")
    .accessibilityValue("\(Int(value)), \(classification.rawValue)")
  }
  
  // Convert value (0-100) to angle (180-0 degrees)
  private func valueToAngle(_ value: Double) -> Double {
    // Clamp value between 0 and 100
    let clampedValue = min(max(value, 0), 100)
    // Map 0-100 to 180-0 degrees
    return 180 - (clampedValue * 1.8)
  }
}

// Custom view for the indicator point that sits on the arc
struct IndicatorPoint: View {
  let angle: Double
  let radius: CGFloat
  
  var body: some View {
    GeometryReader { geometry in
      let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height)
      let pointPosition = pointOnCircle(center: center, radius: radius, angle: angle)
      
      Circle()
        .fill(Color(uiColor: .systemBackground))
        .frame(width: 24, height: 24)
        .overlay(
          Circle()
            .stroke(Color.primary, lineWidth: 2)
        )
        .shadow(color: Color(uiColor: .label).opacity(0.2), radius: 2, x: 0, y: 1)
        .position(pointPosition)
    }
  }
  
  // Calculate position on circle based on angle
  private func pointOnCircle(center: CGPoint, radius: CGFloat, angle: Double) -> CGPoint {
    // Convert angle from degrees to radians
    let radians = angle * .pi / 180
    
    // Calculate position
    let x = center.x + radius * CGFloat(cos(radians))
    let y = center.y - radius * CGFloat(sin(radians))
    
    return CGPoint(x: x, y: y)
  }
}

// Custom shape for semi-circle
struct Arc: Shape {
  let startAngle: Angle
  let endAngle: Angle
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let center = CGPoint(x: rect.midX, y: rect.maxY)
    let radius = min(rect.width, rect.height * 2) / 2
    
    path.addArc(
      center: center,
      radius: radius,
      startAngle: startAngle,
      endAngle: endAngle,
      clockwise: false
    )
    
    return path
  }
}

// MARK: - Previews
#Preview("Extreme Fear (Light)") {
  GaugeView(value: 10, classification: .extremeFear)
    .padding()
    .preferredColorScheme(.light)
}

#Preview("Extreme Fear (Dark)") {
  GaugeView(value: 10, classification: .extremeFear)
    .padding()
    .preferredColorScheme(.dark)
}

#Preview("Neutral (Light)") {
  GaugeView(value: 50, classification: .neutral)
    .padding()
    .preferredColorScheme(.light)
}

#Preview("Neutral (Dark)") {
  GaugeView(value: 50, classification: .neutral)
    .padding()
    .preferredColorScheme(.dark)
}
