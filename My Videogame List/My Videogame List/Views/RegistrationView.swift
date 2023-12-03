//
//  RegistrationView.swift
//  My Videogame List
//
//  Created by alessandro on 02/12/23.
//

import SwiftUI
import Supabase

struct RegistrationView: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @EnvironmentObject var viewModel: LoginView.ViewModel
    @Binding var user: User?
    @State var presentAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Register your new account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
                TextField(text: $email, label: {
                    Text("Email")
                })
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
                SecureField(text: $password, label: {
                    Text("Password")
                })
                .textContentType(.password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
                SecureField(text: $confirmPassword, label: {
                    Text("Confirm password")
                })
                .textContentType(.password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
                Spacer()
                Spacer()
                Button(action: {
                    Task {
                        let registrationAttempt = await viewModel.signUp(email: email, password: password)
                        switch registrationAttempt  {
                            case .success(let currentUser): user = currentUser
                            case .failure(_): presentAlert = true
                        }
                    }
                }, label: {
                    Text("Register")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background((email == "" || password == "" || confirmPassword == "" || (confirmPassword != password)) ? .gray : .blue)
                        .cornerRadius(10)
                })
                .disabled(email == "" || password == "" || confirmPassword == "" || (confirmPassword != password))
                Spacer()
            }
            .alert(isPresented: $presentAlert, content: {
                Alert(title: Text("Failed registration"))
            })
        }
    }
}

#Preview {
    RegistrationView(user: .constant(nil))
}
