//
//  ManageTeamView.swift
//  TestBaseball
//
//  Created by John Lollar on 10/29/22.
//

import SwiftUI

struct ManageTeamView: View {
    
    var team: Team
    
    var body: some View {
        Text("\(team.documentID ?? "")")
            .navigationTitle("\(team.teamName ?? "") \(team.mascotName ?? "")")
    }
}

//struct ManageTeamView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManageTeamView()
//    }
//}
