//
//  QuestionStore.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import Foundation

class QuestionStore: ObservableObject {
	@Published var questions: [Question] = []
	
	func add(question: String) {
		questions.append(Question(question))
	}
}
