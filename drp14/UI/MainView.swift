//
//  ContentView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI
import Firebase

let mostRecentPosts: QuestionStore = QuestionStore()
var dbRef: DatabaseReference! = Database.database().reference()
var recentPosts = Database.database().reference().child("questions").observe(.value, with: { (snapshot) -> Void in
    if snapshot.exists() {
        
        print(snapshot)
        
        let array: NSArray = snapshot.children.allObjects as NSArray
        var question: String
        var detail: String
        var time: Date
        
        for child in array {
            let snap = child as! DataSnapshot
            if snap.value is NSDictionary {
                let data: NSDictionary = snap.value as! NSDictionary
                question = data.value(forKey: "question") as! String
                detail = data.value(forKey: "detail") as! String
                time = data.value(forKey: "time") as! Date
                mostRecentPosts.add(question: question, withDetail: detail, atTime: time)
            }
        }
    }
})

struct MainView: View {
    
    @StateObject var questionStore = mostRecentPosts
    @State private var loggedIn = false
    
    var body: some View {
        TabView {
            QAView(loggedIn: $loggedIn)
                .environmentObject(questionStore)
                .tabItem {
                    Label("Posts", systemImage: "bubble.middle.bottom.fill")
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
