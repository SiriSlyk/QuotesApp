//
//  AuthenticationViewModel.swift
//  Qutoes-App
//
//  Created by Siri Kaarvik Slyk on 11/06/2023.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }

}
