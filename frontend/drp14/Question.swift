//
//  Question.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import Foundation

struct Question: Equatable, Identifiable {
	
	var id: UUID
	private var question: String
	private var time: Date
	
	public init(_ question: String, atTime time: Date, withID id: UUID) {
		self.id = id
		self.question = question
		self.time = time
	}
	
	public init(_ question: String) {
		self.init(question, atTime: Date(), withID: UUID())
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
	
	func getTime() -> Date {
		return self.time
	}
}
