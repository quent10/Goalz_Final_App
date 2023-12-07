//
//  DateSelection.swift
//  goalz_final_App
//
//  Created by Quentin Wingard on 11/16/23.
//

import SwiftUI

struct DateSelectionView: View {
    @State var rotation: CGFloat = 0.0
    @State var segments: [String] = ["1 Week", "4 Days", "1 month", "1 day", "6 months"]
    @State var textFields: [String] = ["1 Week", "4 Days", "1 month", "1 day", "6 months"]
    @State var selectedTime: String = ""

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Spacer()
                    Text("Select Your Time Frame")
                        .font(.title)
                    Spacer()
                    
                    if !selectedTime.isEmpty {
                        Text(selectedTime)
                            .foregroundColor(.red)
                    }
                }

                Wheel(rotation: $rotation, segments: segments)
                    .frame(width: 350, height: 350)
                    .rotationEffect(.radians(rotation))
                    .animation(.easeInOut(duration: 2.0), value: rotation)

                Button("Spin") {
                    let randomAmount = Double(Int.random(in: 7..<15))
                    rotation += CGFloat(randomAmount)
                    
                    let randomIndex = Int.random(in: 0..<textFields.count)
                    selectedTime = textFields[randomIndex]
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

struct Roue: View {
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

struct SpunButtonStyle: ButtonStyle {
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
    static var all_of_em: [Color] {
        [Color.yellow, .green, .pink, .cyan, .orange, .mint, .teal, .blue]
    }
}

struct DateSelection_Previews: PreviewProvider {
    static var previews: some View {
        DateSelectionView()
    }
}
