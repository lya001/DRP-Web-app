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
        retrieveQuestionsFromDB()
    }
	
	func retrieveQuestionsFromDB() {
		Database.database().reference().child("questions").observe(.value, with: { (snapshot) -> Void in
			if snapshot.exists() {
				
				let array: NSArray = snapshot.children.allObjects as NSArray
				var question, detail: String
				var time: Date
				var tags, answers: [String]
				var questionObj: Question
				var id: UUID
				
				self.questions = []
				
				for child in array {
					let snap = child as! DataSnapshot
					id = UUID(uuidString: snap.key)!
					if snap.value is NSDictionary {
						let data: NSDictionary = snap.value as! NSDictionary
						
						// initialize the questino obj
						question = data.value(forKey: "question") as! String
						detail = data.value(forKey: "detail") as! String
						tags = data.value(forKey: "tags") as? [String] ?? []
						answers = data.value(forKey: "answers") as? [String] ?? []
						time = Date(timeIntervalSince1970: data.value(forKey: "time") as! TimeInterval)
						questionObj = Question(question, withDetail: detail, withTags: tags, atTime: time, withID: id)
						
						// retrieve the answers of the question
						for answer in answers {
							questionObj.add(answer: answer)
						}
						
						self.questions.append(questionObj)
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
	
	func update(question: Question) {
		print("updating question \(questions.firstIndex(where: {$0.id == question.id && $0.getQuestion() == question.getQuestion()}) ?? -1)")
		questions[questions.firstIndex(where: {$0.id == question.id})!] = question
	}
}
