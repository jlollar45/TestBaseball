//
//  LoginView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/22/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        GoogleSignInButton()
            .padding()
            .onTapGesture {
                authViewModel.signIn()
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
