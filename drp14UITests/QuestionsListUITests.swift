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

		let questionsList = app.tables["Questions list"]
		XCTAssertEqual(questionsList.cells.count, 0, "There should be no questions when started")
    }
	
	func testAddQuestions() throws {
		let app = XCUIApplication()
		app.launch()
		
		let questionList = app.tables["Questions list"]
		app.buttons["Add Question"].tap()
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
