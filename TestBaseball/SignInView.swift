//
//  SignInView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/29/22.
//

import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices
import Firebase

struct SignInView: View {
    @State var currentNonce:String?
    @Binding var isSignedIn: Bool?
    
    //Hashing function using CryptoKit
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func checkUserDocument(user: User) {
        let reference = Firestore.firestore().collection("Users").document("\(user.uid)")
        
        reference.getDocument { (document, error) in
            if let document = document, document.exists {
                print("document already exists, dumbass")
            } else {
                createUserDocument(reference: reference)
            }
        }
    }
    
    private func createUserDocument(reference: DocumentReference) {
        reference.setData([
            "id": reference.documentID,
            "firstName": "",
            "lastName": "",
            "throws": "",
            "bats": "",
            "level": ""
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    var body: some View {
        
        VStack {
            SignInWithAppleButton(
                
                //Request
                onRequest: { request in
                    let nonce = randomNonceString()
                    currentNonce = nonce
                    request.requestedScopes = [.fullName, .email]
                    request.nonce = sha256(nonce)
                },
                
                //Completion
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            
                            guard let nonce = currentNonce else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                return
                            }
                            
                            let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                            Auth.auth().signIn(with: credential) { (authResult, error) in
                                if (error != nil) {
                                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                                    // you're sending the SHA256-hashed nonce as a hex string with
                                    // your request to Apple.
                                    print(error?.localizedDescription as Any)
                                    return
                                }
                                
                                guard let user = Auth.auth().currentUser else { return }
                                checkUserDocument(user: user)
                                //let currentUser = User(id: user.uid)
                                //print(signInCoordinator.isUserCreated(currentUser: currentUser))
                                
                                isSignedIn = true
                                print("signed in")
                            }
                            
                        default:
                            break
                            
                        }
                    default:
                        break
                    }
                    
                }
            )
            .frame(width: 280, height: 45, alignment: .center)
            
//            Button {
//                let firebaseAuth = Auth.auth()
//                do {
//                    try firebaseAuth.signOut()
//                    isSignedIn = false
//                    print("signed out")
//                } catch let signOutError as NSError {
//                    print("Error signing out: %@", signOutError)
//                }
//            } label: {
//                Text("Sign Out")
//                    .frame(width: 280, height: 45, alignment: .center)
//            }
        }
        
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}

