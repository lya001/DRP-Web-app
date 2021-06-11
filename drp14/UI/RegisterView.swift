//
//  RegisterView.swift
//  drp14
//
//  Created by Yuang Li on 10/06/2021.
//

import Foundation
import SwiftUI
import Firebase

struct RegisterView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @Binding var loggedIn: Bool
    @State private var userName = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    
    var body: some View {
        VStack {
            TextField("User name", text: $userName)
                .padding()
                .background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
                .cornerRadius(10)
                .padding()
            SecureField("Password", text: $password)
                .padding()
                .background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
                .cornerRadius(10)
                .padding()
            TextField("Confirmed Password", text: $confirmedPassword)
                           .padding()
                           .background(Color(UIColor.lightGray
                                               .withAlphaComponent(0.4)))
                           .cornerRadius(10)
                           .padding()

            Button(action: {
                if (password == confirmedPassword) {
                    Database.database().reference().child("users/\(UUID().uuidString)").setValue([
                        "userName": userName,
                        "password": password
                    ])
                    loggedIn = true
                    presentation.wrappedValue.dismiss()
                } 
            }, label: {
                HStack {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                    Image(systemName: "return")
                        .font(Font.title.weight(.bold))
                }
                .padding(.all, 20.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(red: 0.627, green: 0.776, blue: 0.965),
                                lineWidth: 5)
                )
            })
            
            Spacer()
        }
        .navigationTitle("Register")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(loggedIn: .constant(false))
    }
}

