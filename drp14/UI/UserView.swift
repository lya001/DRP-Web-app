//
//  UserView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI

struct UserView: View {
	
	@Binding var loggedIn: Bool
    @Binding var currentUser: String
	
    var body: some View {
		NavigationView {
			if self.loggedIn {
				GeometryReader { geo in
					List {
						HStack {
							Spacer()
							HStack {
								Image(systemName: "person.crop.circle.fill")
									.resizable()
									.frame(width: geo.size.width / 8,
										   height: geo.size.width / 8,
										   alignment: .center)
								Text("User 1").font(.title)
							}
							.padding()
							Spacer()
						}
						
						Section.init {
							NavigationLink(
								destination: Text("My questions list's interface"),
								label: {
									Text("My questions")
								})
							NavigationLink(
								destination: Text("My answers list's interface"),
								label: {
									Text("My answers")
								})
						}
						
						HStack {
							Spacer()
							Button(action: {
								loggedIn = false
							}, label: {
								Text("Log out")
									.font(.title)
									.foregroundColor(.red)
							})
							Spacer()
						}
					}
					.listStyle(InsetGroupedListStyle())
					.navigationTitle("Account")
				}
			}
			else {
				VStack {
					NavigationLink(
                        destination: LoginView(loggedIn: $loggedIn, currentUser: $currentUser),
						label: {
							HStack {
								Text("LOG IN")
									.font(.headline)
									.foregroundColor(Color.blue)
								Image(systemName: "arrow.right")
									.font(Font.title.weight(.bold))
							}
							.padding(.all, 20.0)
							.overlay(
								RoundedRectangle(cornerRadius: 20)
									.stroke(Color(red: 0.627, green: 0.776, blue: 0.965),
											lineWidth: 5)
							)
					})
						.padding()
					
                    NavigationLink(
                        destination: RegisterView(loggedIn: $loggedIn, currentUser: $currentUser),
                        label: {
                            HStack {
                                Text("REGISTER")
                                    .font(.headline)
                                    .foregroundColor(Color.blue)
                                Image(systemName: "arrow.right")
                                    .font(Font.title.weight(.bold))
                            }
                            .padding(.all, 20.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0.627, green: 0.776, blue: 0.965),
                                            lineWidth: 5)
                            )
                        })
				}
				.navigationTitle("Account")
			}
			
		}
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(loggedIn: .constant(true), currentUser: .constant(""))
    }
}
