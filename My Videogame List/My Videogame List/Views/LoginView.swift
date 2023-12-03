//
//  LoginView.swift
//  My Videogame List
//
//  Created by alessandro on 02/12/23.
//

import SwiftUI
import Supabase

struct LoginView: View {
    
    @Binding var user: User?
    @State var email = ""
    @State var password = ""
    @StateObject var viewModel = ViewModel()
    @State var presentAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Welcome to your list of videogames")
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
                Spacer()
                Spacer()
                Button(action: {
                    Task {
                        let loginAttempt = await viewModel.signIn(email: email, password: password)
                        switch loginAttempt  {
                            case .success(let currentUser): user = currentUser
                            case .failure(_): presentAlert = true
                        }
                    }
                }, label: {
                    Text("Login")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background((email == "" || password == "") ? .gray : .blue)
                        .cornerRadius(10)
                })
                .disabled(email == "" || password == "")
                Text("or")
                NavigationLink(destination: RegistrationView(user: $user).environmentObject(viewModel), label: {
                    Text("Register a free account")
                        .font(.title3)
                        .frame(width: 300, height: 30)
                        .cornerRadius(10)
                })
                Spacer()
                    .alert(isPresented: $presentAlert, content: {
                        Alert(title: Text("Failed login"))
                    })
            }
        }
    }
}

#Preview {
    LoginView(user: .constant(nil))
}
