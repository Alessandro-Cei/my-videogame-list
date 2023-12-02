//
//  RegistrationView.swift
//  My Videogame List
//
//  Created by alessandro on 02/12/23.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var username = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Register your new account")
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
                    //Register
                }, label: {
                    Text("Register")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                Spacer()
            }
        }
    }
}

#Preview {
    RegistrationView()
}
