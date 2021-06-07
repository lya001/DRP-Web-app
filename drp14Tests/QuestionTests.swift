//
//  QuestionTests.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import Firebase
import XCTest
@testable import drp14

class QuestionTests: XCTestCase {

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
	
	func testAddQuestionToDB() throws {
		let questionA = "This is a question"
		let time = Date()
		let question = Question(questionA, atTime: time)
		
		// add the question to the database
		question.writeToDB()
		
		// query the question and it should be able to be found in the database
		Database.database().reference().child("questions/\(question.id)").observeSingleEvent(of: .value) { (snapshot) in
			let value = snapshot.value as? NSDictionary
			XCTAssertEqual(value!["question"] as! String, questionA)
			XCTAssertEqual(value!["time"] as! Double, time.timeIntervalSince1970)
			
			// clean up the test -- remove the question from the database
			Database.database().reference().child("questions/\(question.id)").removeValue()
		}
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
