//
//  CarScoutApp.swift
//  CarScout
//
//  Created by Anton Goldsmith on 12/2/23.
//

import SwiftUI
import Firebase

@main
struct CarScoutApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel) // see tut for this in video description
            // doing it this way allows for this to be the only time the function has to be initialized and can be
            // called in any view/file
        }
    }
}
