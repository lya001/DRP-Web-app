//
//  WriteQuestionView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 08/06/2021.
//

import SwiftUI

struct WriteQuestionView: View {
	
	@Environment(\.presentationMode) var presentation
	@EnvironmentObject var questionStore: QuestionStore
	
	@State private var question = ""
	@State private var detail = ""
	
	private let screenWidth = UIScreen.main.bounds.size.width
	private let screenHeight = UIScreen.main.bounds.size.height
	
	init() {
		UITextView.appearance().backgroundColor = .clear
		UIScrollView.appearance().keyboardDismissMode = .onDrag
	}
	
    var body: some View {
		GeometryReader {geo in
			ScrollView {
				HStack {
					Text("Question")
						.font(.title)
						.padding(.top)
						.padding(.leading)
					Spacer()
				}
				TextEditor(text: $question)
					.padding()
					.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
					.cornerRadius(10)
					.frame(width: screenWidth * 0.9, height: screenHeight * 0.3, alignment: .center)
					.padding(.trailing)
					.padding(.leading)
				
				HStack {
					Text("Details/Description")
						.font(.title)
						.padding(.top)
						.padding(.leading)
					Spacer()
				}
				TextEditor(text: $detail)
					.padding()
					.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
					.cornerRadius(10)
					.frame(width: screenWidth * 0.9, height: screenHeight * 0.7, alignment: .center)
					.padding(.trailing)
					.padding(.leading)
				
				HStack {
					Spacer()
					
					Button(action: {
						let question = Question(self.question, withDetail: detail)
						questionStore.add(question: question.getQuestion())
						question.writeToDB()
						presentation.wrappedValue.dismiss()
					}, label: {
						HStack {
							Text("Ask question")
								.font(.headline)
								.foregroundColor(Color.blue)
							Image(systemName: "return")
								.font(Font.title.weight(.bold))
								.foregroundColor(.blue)
						}
					})
					.padding(.all, 20.0)
					.overlay(
						RoundedRectangle(cornerRadius: 20)
							.stroke(Color(red: 0.627, green: 0.776, blue: 0.965),
									lineWidth: 5)
					)
					
					Spacer()
				}
				.padding()
			}
			.navigationTitle("Ask question")
		}
    }
}

struct WriteQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        WriteQuestionView()
    }
}
