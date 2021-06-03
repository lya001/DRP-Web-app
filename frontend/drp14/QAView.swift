//
//  QAView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI

struct QAView: View {
	
	@EnvironmentObject var questionStore: QuestionStore
	
    var body: some View {
		NavigationView {
			List(self.questionStore.questions) { question in
				QuestionRowView(question: question)
			}
			.navigationTitle("QAView")
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
