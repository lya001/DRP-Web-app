//
//  ContentView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
		TabView {
			QAView()
				.tabItem {
					Label("Posts", systemImage: "bubble.middle.bottom.fill")
				}
			UserView()
				.tabItem {
					Label("User", systemImage: "person.circle.fill")
				}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
