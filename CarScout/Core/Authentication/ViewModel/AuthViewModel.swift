//
//  AuthViewModel.swift
//  CarScout
//
//  Created by Anton Goldsmith on 12/3/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor // publishes all UI updates back on the main thread
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser // keeps users logged in if they log in and didn't sign out yet
        
        Task {
            await fetchUser() // try to fetch user data right away
        }
    }
    
    
    func signIn(withEmail email: String, password: String) async throws { //Watch tut from vid description
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser() // needed for user data to be retrieved
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func register(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser) // adds user data to
                                                                                                    // Firestore DB
            await fetchUser()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() //signs user out on backend
            self.userSession = nil // wipes user session and returns to log in screen
            self.currentUser = nil // wipes current user data
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return } // gets the current user's ID
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        // find out what guards do
        self.currentUser = try? snapshot.data(as: User.self)
        
        //print("Current user is: \(self.currentUser)")
        // look into decoding and encoding tut
    }
}
