//
//  FieldView.swift
//  TestBaseball
//
//  Created by John Lollar on 7/29/22.
//

import SwiftUI

struct FieldView: View {
    
    @State private var pitches: [Pitch] = []
    
    let strikeZone = (1...9)
    let outerEdge = (10...13)
    
    let strikeZoneColumns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    let outerEdgeColumns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .fill(.white)
                    .border(.black)
                    .frame(width: geo.size.width * 0.99, height: geo.size.height * 0.8)
                    .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                    .onTapGesture(coordinateSpace: .global) { location in
                        pitches.append(Pitch(location: location, result: .ball))
                    }
                
                LazyVGrid(columns: outerEdgeColumns, spacing: 0) {
                    ForEach(outerEdge, id:\.self) {outerZone in
                        Rectangle()
                            .fill(.white)
                            .border(.black)
                            .frame(height: geo.size.height * 0.31)
                            .onTapGesture(coordinateSpace: .global) { location in
                                pitches.append(Pitch(location: location, result: .ball))
                                print(outerZone)
                            }
                    }
                }
                .frame(width: geo.size.width * 0.85)
                .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                
                LazyVGrid(columns: strikeZoneColumns, spacing: 0) {
                    ForEach(strikeZone, id:\.self) {partOfZone in
                        Rectangle()
                            .fill(.white)
                            .border(.black)
                            .frame(height: geo.size.height * 0.165)
                            .onTapGesture(coordinateSpace: .global) { location in
                                pitches.append(Pitch(location: location, result: .strike))
                                print(partOfZone)
                            }
                    }
                }
                .frame(width: geo.size.width * 0.65)
                .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                
                ForEach(pitches, id: \.id) { pitch in
                    Circle()
                        .fill(pitch.result == .strike ? .red : .green)
                        .frame(width: geo.size.width * 0.05, height: geo.size.width * 0.05)
                        .position(x: pitch.location.x, y: pitch.location.y)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct Pitch {
    let id = UUID()
    let location: CGPoint
    let result: PitchResult
}

enum PitchResult {
    case ball, strike
}
