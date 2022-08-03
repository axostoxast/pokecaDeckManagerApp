//
//  CustomPieChartView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/22.
//

import SwiftUI

@available(OSX 10.15, *)
public struct CustomPieChartView: View {
    public let values: [Int]
    public let names: [String]
    
    public var colors: [Color]
    public var backgroundColor: Color
    
    public var widthFraction: CGFloat
    public var innerRadiusFraction: CGFloat
    
    @State private var activeIndex: Int = -1
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Int = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + Double(degrees)), text: value != 0 ? "\(value * 100 / sum)%" : "", color: self.colors[i]))
            endDeg += Double(degrees)
        }
        return tempSlices
    }
    
    public init(values: [Int], names: [String], colors: [Color] = [Color.blue, Color.green, Color.orange], backgroundColor: Color = Color.white, widthFraction: CGFloat = 0.75, innerRadiusFraction: CGFloat = 0.60) {
        self.values = values
        self.names = names
        
        self.colors = colors
        self.backgroundColor = backgroundColor
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ForEach(0..<self.values.count) { i in
                        CustomPieSlice(pieSliceData: self.slices[i])
                            .scaleEffect(self.activeIndex == i ? 1.03 : 1)
                            .animation(Animation.spring())
                    }
                    .frame(width: widthFraction * geometry.size.width, height: widthFraction * geometry.size.width)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let radius = 0.5 * widthFraction * geometry.size.width
                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                if dist > radius || dist < radius * innerRadiusFraction {
                                    self.activeIndex = -1
                                    return
                                }
                                var radians = Double(atan2(diff.x, diff.y))
                                if radians < 0 {
                                    radians = 2 * Double.pi + radians
                                }
                                
                                for (i, slice) in slices.enumerated() where radians < slice.endAngle.radians {
                                    self.activeIndex = i
                                    break
                                }
                            }
                            .onEnded { _ in
                                self.activeIndex = -1
                            }
                    )
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)
                    
                    VStack {
                        Text(self.activeIndex == -1 ? "Total" : names[self.activeIndex])
                            .foregroundColor(Color("basic"))
                        Text("\(self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex])")
                            .foregroundColor(Color("basic"))
                    }
                    
                }
                PieChartRows(colors: self.colors, names: self.names, values: self.values, percents: self.values.map { $0 * 100 / self.values.reduce(0, +) })
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}

@available(OSX 10.15, *)
struct PieChartRows: View {
    var colors: [Color]
    var names: [String]
    var values: [Int]
    var percents: [Int]
    
    var body: some View {
        VStack {
            ForEach(0..<self.values.count) { i in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[i])
                        .frame(width: 20, height: 20)
                    Text(self.names[i])
                        .foregroundColor(Color("basic"))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(self.values[i])")
                            .foregroundColor(Color("basic"))
                        Text("\(self.percents[i])%")
                            .foregroundColor(Color("basic"))
                    }
                }
            }
        }
    }
}
