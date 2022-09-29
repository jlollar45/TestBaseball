//
//  PlayerPicker.swift
//  TestBaseball
//
//  Created by John Lollar on 9/24/22.
//

import SwiftUI

struct PlayerPicker: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var players = [
        Player(name: "Carson Garner"),
        Player(name: "Cody Garner"),
        Player(name: "Carson Tucker"),
        Player(name: "Dylan Jennings"),
        Player(name: "Kobe Watson"),
        Player(name: "Abram McNutt"),
        Player(name: "Will McCoil")
    ]
    
    var body: some View {
        VStack {
            List {
                Section("Choose a Player") {
                    ForEach(players, id: \.self) { player in
                        NavigationLink(value: player) {
                            Text(player.name)
                        }
                    }
                }
            }
            .navigationDestination(for: Player.self) { player in
                StrikeZoneView(player: player)
            }
        }
        .padding()
    }
}

struct PlayerPicker_Previews: PreviewProvider {
    static var previews: some View {
        PlayerPicker()
    }
}

struct Player: Hashable {
    let name: String
}
