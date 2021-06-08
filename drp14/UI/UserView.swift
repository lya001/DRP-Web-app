//
//  UserView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI

struct UserView: View {
    var body: some View {
		NavigationView {
			GeometryReader { geo in
				List {
					HStack {
						Spacer()
						VStack {
							Image(systemName: "person.crop.circle.fill")
								.resizable()
								.frame(width: geo.size.width / 2,
									   height: geo.size.width / 2,
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
						Text("Log out")
							.font(.title)
							.foregroundColor(.red)
						Spacer()
					}
				}
				.listStyle(InsetGroupedListStyle())
				.navigationTitle("Account")
			}
			
			Spacer()
		}
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
