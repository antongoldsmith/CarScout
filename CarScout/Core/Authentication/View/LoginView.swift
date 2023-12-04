//
//  LoginView.swift
//  CarScout
//
//  Created by Anton Goldsmith on 12/2/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    //image
                    //form fields
                    VStack(spacing: 24) {
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .autocapitalization(.none)
                        
                        InputView(text: $password,
                            title: "Password",
                            placeholder: "Enter your password",
                            isSecureField: true)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    //sign in button
                    
                    Button {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(.blue)
                    .disabled(formIsValid) // disables the sign in button when form is invalid (doesn't meet requirments)
                    .opacity(formIsValid ? 1.0 : 0.5) // keeps the sign in button faded until requirements are met, then makes it fully visible and able to click on
                    .cornerRadius(10)
                    .padding(.top, 24)
                    //sign up button
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                            Text("Sign Up")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .underline()
                        }
                        .font(.system(size: 14))
                    }
                }
//                Image("CarScout Logo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .ignoresSafeArea()
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        // form validation, will use this for registration form as well
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
