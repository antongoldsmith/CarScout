//
//  ContentView.swift
//  CarScout
//
//  Created by Anton Goldsmith on 12/2/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ProfileView() // change this to the apps view somehow
                            // see how to make buttons that launch different views
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
