//
//  FieldView.swift
//  TestBaseball
//
//  Created by John Lollar on 7/29/22.
//

import SwiftUI

struct FieldView: View {
    
    @State private var pitchLocations: [CGPoint] = []
    
    var body: some View {
        ZStack {
            Image("strikeZone")
                .resizable()
                .scaledToFit()
                .onTapGesture(coordinateSpace: .global) { location in
                    pitchLocations.append(location)
                    print(location)
                }
            
            ForEach(pitchLocations, id: \.x) {location in
                Circle()
                    .fill(.red)
                    .frame(width: 20, height: 20)
                    .position(x: location.x, y: location.y)
            }
        }
        .ignoresSafeArea()
    }
}

struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView()
            .previewInterfaceOrientation(.portrait)
    }
}
