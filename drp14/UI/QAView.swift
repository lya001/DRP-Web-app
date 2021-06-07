//
//  QAView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI
import Firebase

struct QAView: View {
	
	@EnvironmentObject var questionStore: QuestionStore
	var dbRef: DatabaseReference! = Database.database().reference()
	
    var body: some View {
		NavigationView {
			List(self.questionStore.questions) { question in
				QuestionRowView(question: question)
			}
			.navigationTitle("Questions")
			.toolbar(content: {
				Button(action: {
					// TODO: should have an interface to write question and save it
					// create a new question and save it
					let question = Question("New question")
					questionStore.add(question: question.getQuestion())
					question.writeToDB()
				}, label: {
					Text("Add Question")
				})
			})
			.accessibility(identifier: "Questions list")
		}
    }
}

struct QAView_Previews: PreviewProvider {
	
	static var questionStore: QuestionStore {
		let questionStore = QuestionStore()
		questionStore.add(question: "qA")
		questionStore.add(question: "qB")
		questionStore.add(question: "qC")
		return questionStore
	}
	
    static var previews: some View {
		QAView().environmentObject(questionStore)
    }
}
