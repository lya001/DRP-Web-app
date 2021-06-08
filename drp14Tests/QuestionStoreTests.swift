//
//  QuestionStoreTests.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import XCTest
@testable import drp14

class QuestionStoreTests: XCTestCase {
	
	let questionStore = QuestionStore()

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testInitializeQuestionStoreWithNoQuestionByDefault() throws {
		XCTAssertEqual(questionStore.questions.count, 0, "There should be no questions when initialized")
	}
	
	func testAddQuestionToQuestionStore() throws {
		questionStore.add(question: "question A")
		XCTAssertEqual(questionStore.questions.count, 1, "There should be one question now!")
	}
	
	func testAddMultipleQuestionToQuestionStore() throws {
		questionStore.add(question: "question A")
		questionStore.add(question: "question B")
		questionStore.add(question: "question C")
		XCTAssertEqual(questionStore.questions.count, 3, "There should be one question now!")
	}

	/*
	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}
	*/

}
