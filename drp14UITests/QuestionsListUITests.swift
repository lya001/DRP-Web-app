//
//  QuestionsListUITests.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import XCTest

class QuestionsListUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitializeQuestionList() throws {
        let app = XCUIApplication()
        app.launch()

		let questionsList = app.tables["questions list"]
		XCTAssertEqual(questionsList.cells.count, 0, "There should be no questions when started")
    }
	
	func testCannotAddQuestionsWithoutLogin() throws {
		let app = XCUIApplication()
		app.launch()
		
		let questionList = app.tables["questions list"]
		app.buttons["Add Question"].tap()
		app.buttons["Cancel"].tap()
		XCTAssertEqual(questionList.cells.count, 0, "No question should be able to be added when the user did not log in.")
	}
	
	func testAddQuestions() throws {
		let app = XCUIApplication()
		app.launch()
		
		let questionList = app.tables["questions list"]
		app.buttons["User"].tap()
		app.buttons["LOG IN"].tap()
		app.buttons["Log in"].tap()
		app.buttons["Posts"].tap()
		app.buttons["Add Question"].tap()
		while !app.buttons["Ask question"].exists {
			app.swipeUp()
		}
		app.buttons["Ask question"].tap()
		XCTAssertEqual(questionList.cells.count, 1, "There should be one question after pressing the \"Add Question\" button.")
	}

	/*
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
	*/
}
