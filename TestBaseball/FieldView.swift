//
//  FieldView.swift
//  TestBaseball
//
//  Created by John Lollar on 7/29/22.
//

import SwiftUI

struct FieldView: View {
    
    @State private var pitches: [Pitch] = []
    
    enum PitchResult {
        case ball, strike
    }
    
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
                LazyVGrid(columns: outerEdgeColumns, spacing: 0) {
                    ForEach(outerEdge, id:\.self) {outerZone in
                        Rectangle()
                            .fill(.white)
                            .border(.black)
                            .frame(height: geo.size.height * 0.31)
                            .onTapGesture(coordinateSpace: .global) { location in
                                pitches.append(Pitch(location: location))
                                print(outerZone)
                            }
                    }
                }
                .frame(width: geo.size.width * 0.85)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                
                LazyVGrid(columns: strikeZoneColumns, spacing: 0) {
                    ForEach(strikeZone, id:\.self) {partOfZone in
                        Rectangle()
                            .fill(.white)
                            .border(.black)
                            .frame(height: geo.size.height * 0.165)
                            .onTapGesture(coordinateSpace: .global) { location in
                                pitches.append(Pitch(location: location))
                                print(partOfZone)
                            }
                    }
                }
                .frame(width: geo.size.width * 0.65)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                
                ForEach(pitches, id: \.id) { pitch in
                    Circle()
                        .fill(.red)
                        .frame(width: geo.size.width * 0.05, height: geo.size.width * 0.05)
                        .position(x: pitch.location.x, y: pitch.location.y)
                }
            }
            .ignoresSafeArea()
        }
        
       
//        ZStack {
//            Image("strikeZone")
//                .resizable()
//                .scaledToFit()
//                .onTapGesture(coordinateSpace: .global) { location in
//                    pitchLocations.append(location)                    print(location)
//                }
//
//            ForEach(pitchLocations, id: \.x) {location in
//                Circle()
//                    .fill(.red)
//                    .frame(width: 20, height: 20)
//                    .position(x: location.x, y: location.y)
//            }
//        }
//        .ignoresSafeArea()
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
}
