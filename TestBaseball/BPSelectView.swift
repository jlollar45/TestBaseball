//
//  BPSelectView.swift
//  TestBaseball
//
//  Created by John Lollar on 10/21/22.
//

import SwiftUI

struct BPSelectView: View {
    var body: some View {
        GeometryReader { geo in
            VStack (spacing: 20){
                NavigationLink(value: true) {
                    VStack {
                        Text("Cage Batting Practice")
                            .font(.title)
                            .padding()
                        
                        Divider()
                        
                        Text("Keep track of barrels only inside the batting cage")
                            .font(.caption)
                            .padding()
                    }
                    .frame(width: geo.size.width * 0.7)
                    
                }
                .buttonStyle(.bordered)
                
                NavigationLink(value: false) {
                    VStack {
                        Text("On-Field Batting Practice")
                            .font(.title)
                            .padding()
                        
                        Divider()
                        
                        Text("Keep track of hit location, and type of contact on the field")
                            .font(.caption)
                            .padding()
                    }
                    .frame(width: geo.size.width * 0.7)
                }
                .buttonStyle(.bordered)
            }
            .navigationDestination(for: Bool.self) { isCageBP in
                FieldView()
            }
            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY - 80)
        }
    }
}

struct BPSelectView_Previews: PreviewProvider {
    static var previews: some View {
        BPSelectView()
    }
}
