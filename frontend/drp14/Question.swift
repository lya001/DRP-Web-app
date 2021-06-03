//
//  Question.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import Foundation

struct Question: Equatable {
	
	private var question: String
	
	public init(_ question: String) {
		self.question = question
	}
	
	static func ==(lhs: Question, rhs: Question) -> Bool {
		return lhs.question == rhs.question
	}
	
	mutating func update(question: String) {
		self.question = question
	}
	
	func getQuestion() -> String {
		return self.question
	}
}
