//
//  User.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import Foundation
import Firebase

//struct User {
//
//    var id: String
//    var email: String?
//    var name: String?
//    var isCoach: Bool?
//    var isPlayer: Bool?
//
//}

struct AppUser: Hashable {
    var id: UUID
    var firstName: String?
    var lastName: String?
    var bats: String?
    var hand: String?
    var level: String?
    var isCoach: Bool?
    var teams: [DocumentReference]?
    //var bullpens: [Pens]?
    //var bps: [BPs]?
}

struct Team: Hashable {
    let id: UUID
    let name: String?
    let players: [AppUser]?
    let coaches: [AppUser]?
    let level: String?
    //var bullpens: [Pens]?
    //var bps: [BPs]?
}

class Teams: ObservableObject {
    @Published var teams = [Team]()
}

//class Teams: NSObject, NSCoding {
//    var teams: [DocumentReference]
//
//    func encode(with coder: NSCoder) {
//        coder.encode(teams, forKey: "teams")
//    }
//
//    required init?(coder: NSCoder) {
//        self.teams = coder.decodeObject(forKey: "teams") as? [DocumentReference] ?? []
//    }
//}
