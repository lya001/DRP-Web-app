//
//  ContentView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI
import Firebase

struct MainView: View {
    
    @StateObject var questionStore = QuestionStore()
    @State private var loggedIn = false
    
    var body: some View {
        TabView {
            QAView(loggedIn: $loggedIn)
                .environmentObject(questionStore)
                .tabItem {
                    Label("Posts", systemImage: "bubble.middle.bottom.fill")
                }
            HouseView(loggedIn: $loggedIn)
                .tabItem { Label("House", systemImage: "house.fill") }
            ExperienceView(loggedIn: $loggedIn)
                .tabItem {
                    Label("Experience", systemImage: "square.and.pencil")
                }
            UserView(loggedIn: $loggedIn)
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
