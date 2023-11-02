//
//  ContentView.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @State var rotation: CGFloat = 0.0
    @State var segments: [String] = ["Eat 6 banane", "Eat 1 banane", "Build a snowman", "Build a castle", "Meditate"]
    @State var textFields: [String] = ["Eat 6 banane", "Eat 1 banane", "Build a snowman", "Build a castle", "Meditate"]

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Text("Select Your Goal")
                        .font(.title)
                    Spacer()
                }

                Wheel(rotation: $rotation, segments: segments)
                    .frame(width: 350, height: 350)
                    .rotationEffect(.radians(rotation))
                    .animation(.easeInOut(duration: 2.0), value: rotation)

                Button("Spin") {
                    let randomAmount = Double(Int.random(in: 7..<15))
                    rotation += CGFloat(randomAmount)
                }
                .buttonStyle(SpinButtonStyle())
                .padding(.top, 20)

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(0..<5, id: \.self) { index in
                        TextField("Segment \(index + 1)", text: $textFields[index])
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: textFields[index]) { newValue in
                                if !newValue.isEmpty {
                                    segments[index] = newValue
                                }
                            }
                    }
                }
            }
            .padding()
        }
    }
}

struct Wheel: View {
    @Binding var rotation: CGFloat
    var segments: [String]

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(segments.indices, id: \.self) { index in
                    ZStack {
                        Circle()
                            .inset(by: proxy.size.width / 4)
                            .trim(from: CGFloat(index) * segmentSize, to: CGFloat(index + 1) * segmentSize)
                            .stroke(Color.all[index % Color.all.count], style: StrokeStyle(lineWidth: proxy.size.width / 2))
                            .rotationEffect(.radians(Double(index) * (2 * .pi) / Double(segments.count)))
                            .opacity(0.6)
                        label(text: segments[index], index: CGFloat(index), proxy: proxy)
                    }
                }
            }
        }
    }

    var segmentSize: CGFloat {
        segments.isEmpty ? 1 : 1 / CGFloat(segments.count)
    }

    func label(text: String, index: CGFloat, proxy: GeometryProxy) -> some View {
        let radius = proxy.size.width / (4 * 0.9)
        let angle = 2 * .pi * Double(index) / Double(segments.count)
        let x = cos(angle) * radius
        let y = sin(angle) * radius

        return Text(text)
            .rotationEffect(.radians(rotation(index: index) - .pi / 6))
            .offset(x: x - 10 , y: y)
    }

    func rotation(index: CGFloat) -> CGFloat {
        (.pi * (2 * segmentSize * (CGFloat(index) + 0.5)))
    }
}

struct SpinButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .opacity(0.8)
    }
}

extension Color {
    static var all: [Color] {
        [Color.yellow, .green, .pink, .cyan, .orange, .mint, .teal, .blue]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
