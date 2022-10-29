//
//  CreateTeamView.swift
//  TestBaseball
//
//  Created by John Lollar on 10/22/22.
//

import SwiftUI

struct CreateTeamView: View {
    
    @ObservedObject var coordinator = Coordinator()
    
    var body: some View {
        //NavigationStack(path: $coordinator.path) {
            GeometryReader { geo in
                Form {
                    Section("Name") {
                        
                    }
                }
            }
        //}
    }
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView()
    }
}
