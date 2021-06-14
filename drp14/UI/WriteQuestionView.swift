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
	@State private var tags: [String] = []
	@State private var addTagViewPresented = false
	
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
					.frame(width: screenWidth * 0.9, height: screenHeight * 0.2, alignment: .center)
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
					.frame(width: screenWidth * 0.9, height: screenHeight * 0.3, alignment: .center)
					.padding(.trailing)
					.padding(.leading)
				
				HStack {
					if !tags.isEmpty {
						Text("Tags")
							.font(.title)
							.padding()
					}
					Button(action: {
						   addTagViewPresented = true
					   }, label: {
						Spacer()
						Text("add tag +")
							.padding(.all, 10.0)
							.overlay(
								RoundedRectangle(cornerRadius: 8)
									.stroke(Color(red: 0.627, green: 0.776, blue: 0.965),
											lineWidth: 5)
							)
							.padding()
					   })
					   .sheet(isPresented: $addTagViewPresented, content: {
						   AddTagView(tags: $tags)
					   })
					
					Spacer()
				}
				
				VStack {
					if !tags.isEmpty {
						ForEach(tags, id: \.self) { tag in
							HStack {
								Text(tag)
									.padding(7)
									.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
									.cornerRadius(5)
									.padding(.leading)
									.padding(.top, 5)
									.onTapGesture {
										tags.remove(at: tags.firstIndex(of: tag)!)
									}
								Image(systemName: "minus.circle.fill")
									.foregroundColor(.red)
									.onTapGesture {
										tags.remove(at: tags.firstIndex(of: tag)!)
									}
								Spacer()
							}
						}
					}
				}
				
				HStack {
					Spacer()
					
					Button(action: {
                        let question = Question(self.question, withDetail: detail, withTags: tags)
						questionStore.addQuestion(question)
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
