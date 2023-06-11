//
//  SettingsViewModel.swift
//  Qutoes-App
//
//  Created by Siri Kaarvik Slyk on 11/06/2023.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authUser: AuthDataResultModel? = nil
    
    /*func loadAuthProviders() {
        ...
    }*/
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    /*func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassworld(email: email)
    }*/
    
    /*func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        self.authUser = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
    }*/
}
