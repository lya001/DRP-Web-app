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
    var dbRef: DatabaseReference! = Database.database().reference()
    
    @Binding var loggedIn: Bool
    @State private var userName = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @State private var alertConfirmedPassword = false
    @State private var existedUsername = false
    
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
            SecureField("Confirmed password", text: $confirmedPassword)
                           .padding()
                           .background(Color(UIColor.lightGray
                                               .withAlphaComponent(0.4)))
                           .cornerRadius(10)
                           .padding()

            Button(action: {
                dbRef.child("users").queryOrdered(byChild: "userName")
                    .queryEqual(toValue: userName)
                    .observeSingleEvent(of: .value) { (snapshot) -> Void in
                        if snapshot.exists() {
                            existedUsername = true
                            print("existed user name")
                        } else if (password == confirmedPassword) {
                            dbRef.child("users/\(UUID().uuidString)").setValue([
                                "userName": userName,
                                "password": password
                            ])
                            loggedIn = true
                            presentation.wrappedValue.dismiss()
                        } else {
                            alertConfirmedPassword = true
                        }
                    }
            }, label: {
                HStack {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                        .alert(isPresented: $existedUsername, content: {
                            return Alert(title: Text("Warning"),
                                         message: Text("User name \"" + userName + "\" already exists"),
                                         dismissButton: .cancel())
                        })
                    Image(systemName: "return")
                        .font(Font.title.weight(.bold))
                        .alert(isPresented: $alertConfirmedPassword, content: {
                            return Alert(title: Text("Warning"),
                                         message: Text("Confirmed password is not the same as the password. You must enter the same password twice"),
                                         dismissButton: .cancel())
                        })
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

