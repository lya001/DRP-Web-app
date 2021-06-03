//
//  drp14Tests.swift
//  drp14Tests
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import XCTest
@testable import drp14

class questionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testCreateQuestion() throws {
		let questionA = "This is a question"
		let question = Question(questionA)
		XCTAssertEqual(question.getQuestion(), questionA, "It should be question A!")
	}

    func testUpdateQuestion() throws {
		let questionA = "This is another question"
		var question = Question("random")
		question.update(question: questionA)
		XCTAssertEqual(question.getQuestion(), questionA, "It should be question A!")
    }
	
	func testTimeOfPostedQuestion() throws {
		let time = Date()
		let question = Question("random", atTime: time)
		XCTAssertEqual(question.getTime(), time, "It should be at \(time)")
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
