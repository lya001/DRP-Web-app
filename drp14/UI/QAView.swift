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
	
	@State private var searchText = ""
	@State private var showCancelButton: Bool = false
	@Binding var loggedIn: Bool
    @Binding var currentUser: String
	@State private var alertPresent = false
	@State private var startAskingQuestion = false
	
    var body: some View {
		NavigationView {
			
			// Search view
			VStack {
				
				NavigationLink(
					destination: WriteQuestionView().environmentObject(questionStore),
					isActive: $startAskingQuestion,
					label: {
						EmptyView()
					})
				
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
					ForEach(self.questionStore.questions.filter{
								$0.getQuestion().localizedCaseInsensitiveContains(searchText)
									|| $0.getTags().joined(separator: " ").localizedCaseInsensitiveContains(searchText)
									|| searchText == ""
					}, id: \.id) { searchQuestion in
						NavigationLink(destination: PostView(question: searchQuestion).environmentObject(questionStore), label: {
							QuestionRowView(question: searchQuestion)
						})
					}
				}
				.listStyle(InsetListStyle())
				.navigationTitle("Questions")
				.toolbar(content: {
					Button(action: {
						if loggedIn {
							startAskingQuestion = true
						} else {
							alertPresent = true
						}
					}, label: {
						Text("Add question")
					})
				})
				.alert(isPresented: $alertPresent, content: {
					return Alert(title: Text("Warning"),
								 message: Text("You must log in in order to ask questions. Please go to \"User\" tab to log in."),
								 dismissButton: .cancel())
				})
				.accessibility(identifier: "questions list")
				.onAppear(perform: {
					questionStore.retrieveQuestionsFromDB()
				})
			}
		}
    }
}

struct QAView_Previews: PreviewProvider {
	
	static var questionStore: QuestionStore {
		let questionStore = QuestionStore()
		questionStore.add(question: "qA is known", withDetail: "", withTags: ["nice"])
		questionStore.add(question: "qB is  not known", withDetail: "Nothing fancy", withTags: ["Halo there and", "world!"])
		questionStore.add(question: "qChahah", withDetail: "Nothing for now", withTags: ["yo", "lower case", "right"])
		return questionStore
	}
	
    static var previews: some View {
        QAView(loggedIn: .constant(false), currentUser: .constant("")).environmentObject(questionStore)
    }
}
