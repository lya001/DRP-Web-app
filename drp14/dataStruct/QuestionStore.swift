//
//  QuestionStore.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import Foundation

class QuestionStore: ObservableObject {
	@Published var questions: [Question] = []
	
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
    
    func add(question: String, withDetail detail: String, atTime time: Date) {
        questions.append(Question(question, withDetail: detail, atTime: time))
    }
}
