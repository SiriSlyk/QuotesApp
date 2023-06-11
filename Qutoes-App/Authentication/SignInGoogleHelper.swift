//
//  SignInGoogleHelper.swift
//  Qutoes-App
//
//  Created by Siri Kaarvik Slyk on 11/06/2023.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel{
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResulat = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        //gidSignInResulat.user
        
        guard let idToken = gidSignInResulat.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResulat.user.accessToken.tokenString
        
        return GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)

    }
}

