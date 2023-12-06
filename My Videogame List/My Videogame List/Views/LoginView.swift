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
    @State private var isAlertPresented = false
    
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
                        try await viewModel.signIn(email: email, password: password)
                        user = viewModel.user
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
                    .onReceive(viewModel.$error, perform: { error in
                        if (error != nil) {
                            isAlertPresented.toggle()
                        }
                    })
                    .alert(isPresented: $isAlertPresented, content: {
                        Alert(
                            title: Text("Error"),
                            message: Text(viewModel.error?.localizedDescription ?? "")
                        )
                    })
            }
        }
    }
}

#Preview {
    LoginView(user: .constant(nil))
}
