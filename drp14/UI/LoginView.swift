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
	@State private var userName = ""
	@State private var password = ""
    @State private var noUsername = false
    @State private var correctPassword = false
	
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
			Button(action: {
                dbRef.child("users").queryOrdered(byChild: "userName")
                    .queryEqual(toValue: userName)
                    .observeSingleEvent(of: .value) { (snapshot) -> Void in
                        if snapshot.exists() {
                            
                                loggedIn = true
                                presentation.wrappedValue.dismiss()
                           
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
		LoginView(loggedIn: .constant(false))
    }
}
