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
	
	let array = ["Peter", "Paul", "Mary", "Anna-Lena", "George", "John", "Greg", "Thomas", "Robert", "Bernie", "Mike", "Benno", "Hugo", "Miles", "Michael", "Mikel", "Tim", "Tom", "Lottie", "Lorrie", "Barbara"]
	@State private var searchText = ""
	@State private var showCancelButton: Bool = false
	
	
    var body: some View {
		NavigationView {
			
			// Search view
			VStack {
				HStack {
					HStack {
						Image(systemName: "magnifyingglass")

						TextField("search", text: $searchText, onEditingChanged: { isEditing in
							self.showCancelButton = true
						}, onCommit: {
							print("onCommit")
						}).foregroundColor(.primary)

						Button(action: {
							self.searchText = ""
						}) {
							Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
						}
					}
					.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
					.foregroundColor(.secondary)
					.background(Color(.secondarySystemBackground))
					.cornerRadius(10.0)

					if showCancelButton  {
						Button("Cancel") {
								UIApplication.shared.endEditing(true) // this must be placed before the other commands here
								self.searchText = ""
								self.showCancelButton = false
						}
						.foregroundColor(Color(.systemBlue))
					}
				}
				.padding(.horizontal)
				.navigationBarHidden(showCancelButton)
				.animation(.none)
				
				List {
					ForEach(self.questionStore.questions.filter{$0.getQuestion().hasPrefix(searchText) || searchText == ""}, id: \.self) { searchQuestion in
						QuestionRowView(question: searchQuestion)
					}

				}
				.listStyle(InsetListStyle())
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
