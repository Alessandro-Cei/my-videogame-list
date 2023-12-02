//
//  LoginView.swift
//  My Videogame List
//
//  Created by alessandro on 02/12/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Welcome to your list of videogames")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
                TextField(text: $username, label: {
                    Text("Username")
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
                    //Login
                }, label: {
                    Text("Login")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                Text("or")
                NavigationLink(destination: RegistrationView(), label: {
                    Text("Register a free account")
                        .font(.title3)
                        .frame(width: 300, height: 30)
                        .cornerRadius(10)
                })
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
