//
//  Qutoes_AppApp.swift
//  Qutoes-App
//
//  Created by Siri Kaarvik Slyk on 11/06/2023.
//

import SwiftUI
import FirebaseCore

@main
struct Qutoes_AppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
