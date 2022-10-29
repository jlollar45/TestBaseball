//
//  TeamPicker.swift
//  TestBaseball
//
//  Created by John Lollar on 9/25/22.
//

import SwiftUI

struct TeamPicker: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    //var teams = [Team(name: "Murray High Tigers")]
    @State private var selectedTeam = ""
    @State private var teamSelected = false
    @State private var bullpen = false
    @State private var bp = false
    
    var isBattingPractice: Bool
    
    var body: some View {
        VStack {
            List {
                Section("Choose a Team") {
//                    ForEach(teams, id: \.self) { team in
//                        NavigationLink(value: team) {
//                            Text(team.name)
//                        }
//                    }
                }
            }
            .navigationDestination(for: Team.self) { team in
                if isBattingPractice {
                    FieldView()
                } else {
                    PlayerPicker()
                }
            }
            .padding()
        }
        .navigationTitle(isBattingPractice ? "Batting Practice" : "Bullpen")
        .navigationBarTitleDisplayMode(.large)
        .toolbar(.visible, for: .tabBar)
    }
}

struct TeamPicker_Previews: PreviewProvider {
    static var previews: some View {
        TeamPicker(isBattingPractice: false)
    }
}


