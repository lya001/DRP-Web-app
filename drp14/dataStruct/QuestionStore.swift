//
//  QuestionStore.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import Foundation
import Firebase

class QuestionStore: ObservableObject {
    @Published var questions: [Question]
    
    init() {
        questions = []
        _ = Database.database().reference().child("questions").observe(.value, with: { (snapshot) -> Void in
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
                        time = Date(timeIntervalSince1970: data.value(forKey: "time") as! TimeInterval) 
                        self.questions.append(Question(question, withDetail: detail, atTime: time))
                    }
                }
            }
        })
    }
    
    func addQuestion(_ question: Question) {
        questions.append(question)
    }
    
    func add(question: String) {
        questions.append(Question(question))
    }
    
    func add(question: String, detail: String) {
        questions.append(Question(question, withDetail: detail))
    }
    
    func add(question: String, withDetail detail: String, withTags tags: [String]) {
        questions.append(Question(question, withDetail: detail, withTags: tags))
    }
}
