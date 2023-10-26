//
//  ContentView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var rotationAngle: Double = 0

    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<8, id: \.self) { index in
                    let colorSegment = colorSegments[index % colorSegments.count]
                    Wheel(startAngle: .degrees(Double(index) * 45), endAngle: .degrees(Double(index + 1) * 45))
                        .fill(colorSegment.color)
                        .rotationEffect(.degrees(rotationAngle), anchor: .center)
                }
            }
            Button("Spin") {
                withAnimation(Animation.linear(duration: 2)) {
                    rotationAngle = Double.random(in: 360...1440)
                }
            }
            .font(.title)
        }
        .padding()
    }

    let colorSegments: [ColorSegment] = [
        ColorSegment(color: .red),
        ColorSegment(color: .blue),
        ColorSegment(color: .green),
        ColorSegment(color: .yellow),
        ColorSegment(color: .purple),
        ColorSegment(color: .orange),
        ColorSegment(color: .pink),
        ColorSegment(color: .mint)
    ]
}

struct Wheel: Shape {
    var startAngle: Angle
    var endAngle: Angle
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSegment {
    let color: Color
}
