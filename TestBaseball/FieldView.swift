//
//  FieldView.swift
//  TestBaseball
//
//  Created by John Lollar on 7/29/22.
//

import SwiftUI

struct FieldView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var pitches: [Pitch] = []
    @State private var pitchType = 1
    
    let strikeZone = (1...9)
    let outerEdge = (10...13)
    
    let strikeZoneColumns = [
        GridItem(.flexible(), spacing: -1),
        GridItem(.flexible(), spacing: -1),
        GridItem(.flexible(), spacing: -1)
    ]
    
    let outerEdgeColumns = [
        GridItem(.flexible(), spacing: -1),
        GridItem(.flexible(), spacing: -1)
    ]
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .subheadline)], for: .highlighted)
            
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .subheadline)], for: .normal)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack (spacing: 0) {
                
                Text("Pitcher: John Lollar")
                    .font(.largeTitle)
                    .frame(height: geo.size.height * 0.08)
                
                Picker("Type of Pitch Thrown", selection: $pitchType) {
                    Text("Fastball").tag(1).font(.largeTitle)
                    Text("Curveball").tag(2)
                    Text("Slider").tag(3)
                    Text("Changeup").tag(4)
                }
                .pickerStyle(.segmented)
                .frame(height: geo.size.height * 0.05)
                .padding(EdgeInsets(top: geo.size.height * 0.03, leading: geo.size.width * 0.05, bottom: geo.size.height * 0.05, trailing: geo.size.width * 0.05))
                
                ZStack {
                    Rectangle()
                        .fill(colorScheme == .dark ? .black : .white)
                        .border(colorScheme == .dark ? .white : .black, width: 2)
                        .onTapGesture(coordinateSpace: .named("StrikeZone")) { location in
                            pitches.append(Pitch(location: location, result: .ball, type: pitchType))
                        }
                    
                    LazyVGrid(columns: outerEdgeColumns, spacing: 0) {
                        ForEach(outerEdge, id:\.self) {outerZone in
                            Rectangle()
                                .fill(colorScheme == .dark ? .black : .white)
                                .border(colorScheme == .dark ? .white : .black, width: 2)
                                .frame(height: geo.size.height * 0.24)
                                .onTapGesture(coordinateSpace: .named("StrikeZone")) { location in
                                    pitches.append(Pitch(location: location, result: .ball, type: pitchType))
                                }
                        }
                    }
                    .frame(width: geo.size.width * 0.78)
                    
                    LazyVGrid(columns: strikeZoneColumns, spacing: 0) {
                        ForEach(strikeZone, id:\.self) {partOfZone in
                            Rectangle()
                                .fill(colorScheme == .dark ? .black : .white)
                                .border(colorScheme == .dark ? .white : .black, width: 2)
                                .frame(height: geo.size.height * 0.13)
                                .onTapGesture(coordinateSpace: .named("StrikeZone")) { location in
                                    pitches.append(Pitch(location: location, result: .strike, type: pitchType))
                                }
                        }
                    }
                    .frame(width: geo.size.width * 0.58)
                    
                    ForEach(pitches, id: \.id) { pitch in
                        ZStack {
                            Circle()
                                .fill(pitch.result == .strike ? .red : .green)
                                .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                .position(x: pitch.location.x, y: pitch.location.y)
                                .onTapGesture{
                                    print("edited")
                                }
                            
                            Text("\(pitch.getTypeString(type: pitch.type))")
                                .frame(width: geo.size.width * 0.08, height: geo.size.width * 0.08)
                                .position(x: pitch.location.x, y: pitch.location.y)
                        }
                    }
                }
                .frame(width: geo.size.width * 0.99, height: geo.size.height * 0.6)
                .coordinateSpace(name: "StrikeZone")
                
                
                Button {
                    print("finish session")
                } label: {
                    Text("Finish Session")
                        .font(.title)
                        .frame(width: geo.size.width * 0.7)
                }
                .buttonStyle(CustomButton())
                .padding(EdgeInsets(top: geo.size.height * 0.05, leading: geo.size.width * 0.05, bottom: geo.size.height * 0.05, trailing: geo.size.width * 0.05))
            }
        }
    }
}

struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView().previewInterfaceOrientation(.portrait)
    }
}

struct Pitch {
    let id = UUID()
    let location: CGPoint
    let result: PitchResult
    let type: Int
    let typeDict = [1: "FB", 2: "CB", 3: "SL", 4: "CH", 5: "SP", 6: "KN"]
    
    func getTypeString(type: Int) -> String {
        if let string = typeDict[type] {
            return string
        } else {
            return "NA"
        }
    }
}

enum PitchResult {
    case ball, strike
}

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)  // << here !!
    }
}
