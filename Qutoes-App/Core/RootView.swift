//
//  RootView.swift
//  Qutoes-App
//
//  Created by Siri Kaarvik Slyk on 11/06/2023.
//

import SwiftUI

struct RootView: View {
    
    @State private var showeSignInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                ProfileView(showSignInView: $showeSignInView)
                
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showeSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showeSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showeSignInView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
