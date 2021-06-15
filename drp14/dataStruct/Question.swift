//
//  Question.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import Foundation
import Firebase

struct Question: Equatable, Identifiable, Hashable {
	
	var id: UUID
	private var question: String
	private var detail: String
	private var answers: [String] = []
	private var time: Date
	private var tags: [String]
	
	public init(_ question: String, withDetail detail: String, withTags tags: [String], atTime time: Date, withID id: UUID) {
		self.id = id
		self.question = question
		self.detail = detail
		self.tags = tags
		self.time = time
	}
	
	public init(_ question: String, withDetail detail: String, withTags tags: [String]) {
		self.init(question, withDetail: detail, withTags: tags, atTime: Date(), withID: UUID())
	}
	
	public init(_ question: String, withDetail detail: String) {
		self.init(question, withDetail: detail, withTags: [])
	}
	
	public init(_ question: String, atTime time: Date) {
		self.init(question, withDetail: "", withTags: [], atTime: time, withID: UUID())
	}
	
	public init(_ question: String) {
		self.init(question, withDetail: "", withTags: [])
	}
	
	static func ==(lhs: Question, rhs: Question) -> Bool {
		return lhs.question == rhs.question
	}
	
	mutating func update(question: String) {
		self.question = question
	}
	
	mutating func add(answer: String) {
		if answer != "" {
			self.answers.append(answer)
			Database.database().reference().child("questions/\(id.uuidString)/anwers/answer_\(answers.count)").setValue(answer)
		}
	}
	
	func getQuestion() -> String {
		return self.question
	}
    
    func getDetail() -> String {
        return self.detail
    }
	
	func getTime() -> Date {
		return self.time
	}
	
	func getTags() -> [String] {
		return self.tags
	}
	
	func getAnswers() -> [String] {
		return self.answers
	}
	
	func writeQuestionToDB() {
		Database.database().reference().child("questions/\(id.uuidString)").setValue([
			"question": question,
			"detail": detail,
			"time": time.timeIntervalSince1970,
			"tags": tags
		])
	}
}
