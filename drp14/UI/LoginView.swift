//
//  LoginView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 08/06/2021.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentation
    var dbRef: DatabaseReference! = Database.database().reference()
    
    @Binding var loggedIn: Bool
    @Binding var currentUser: String
    @State private var userName = ""
    @State private var password = ""
    @State private var noUsername = false
    @State private var incorrectPassword = false
    
    var body: some View {
        VStack {
            HStack {
                Text("User name")
                    .font(.body)
                    .padding(.top)
                    .padding(.leading)
                Spacer()
            }
            TextField("User name", text: $userName)
                .padding()
                .background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
                .cornerRadius(10)
                .padding()
            HStack {
                Text("Password")
                    .font(.body)
                    .padding(.top)
                    .padding(.leading)
                Spacer()
            }
            SecureField("Password", text: $password)
                .padding()
                .background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
                .cornerRadius(10)
                .padding()
            Button(action: {
                dbRef.child("users").queryOrdered(byChild: "userName")
                    .queryEqual(toValue: userName)
                    .observeSingleEvent(of: .value) { (snapshot) -> Void in
                        if (snapshot.exists()) {
                            let array: NSArray = snapshot.children.allObjects as NSArray
                            
                            var dbPassword: String = "An Impossible Password"
                            
                            for child in array{
                                let snap = child as! DataSnapshot
                                
                                if snap.value is NSDictionary {
                                    let data: NSDictionary = snap.value as! NSDictionary
                                    
                                    dbPassword = data.value(forKey: "password") as! String
                                }
                            }
                            
                            if password == dbPassword {
                                loggedIn = true
                                currentUser = userName
                                presentation.wrappedValue.dismiss()
                            } else {
                                incorrectPassword = true
                            }
                        } else {
                            noUsername = true
                        }
                    }
            }, label: {
                HStack {
                    Text("Log in")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                        .alert(isPresented: $noUsername, content: {
                            return Alert(title: Text("Warning"),
                                         message: Text("User name \"" + userName + "\" does not exist. Please try again."),
                                         dismissButton: .cancel())
                        })
                    Image(systemName: "return")
                        .font(Font.title.weight(.bold))
                        .alert(isPresented: $incorrectPassword, content: {
                            return Alert(title: Text("Warning"),
                                         message: Text("Password entered is incorrect for User name \"" + userName + "\". Please try again."),
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
        .navigationTitle("Log in")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loggedIn: .constant(false), currentUser: .constant(""))
    }
}
