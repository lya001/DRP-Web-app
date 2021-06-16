//
//  PostView.swift
//  drp14
//
//  Created by Yuang Li on 10/06/2021.
//

import SwiftUI

struct PostView: View {
    
    @State var question: Question
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
	private let noDetailString = "No more details provided."
	private let noTagString = "No tags specified for this question."
	private let noAnswerString = "Currently there is no answer for this question."
	
	@EnvironmentObject var questionStore: QuestionStore
	@Environment(\.presentationMode) var presentation
	@State var answeringQuestion = false
	@State var answer = ""
	
	init(question: Question) {
		
		print("________")
		print("It seems like the data is updated, but WHY IS THE VIEW NOT UPDTAED???")
		print(question)
		
		self._question = State(initialValue: question)
		print(self.question)
		print("--------")
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
				HStack {
					Text(question.getQuestion())
						.padding()
						.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
						.cornerRadius(10)
						.padding()
					Spacer()
				}
                HStack {
                    Text("Details/Description")
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                }
				HStack {
					Text(question.getDetail() != "" ? question.getDetail() : noDetailString)
						.padding()
						.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
						.cornerRadius(10)
						.padding()
					Spacer()
				}
				HStack {
					Text("Tags")
						.font(.title)
						.padding(.leading)
					Spacer()
				}
				HStack {
					Text(question.getTags().count != 0 ? question.getTags().joined(separator: ", ") : noTagString)
						.padding()
						.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
						.cornerRadius(10)
						.padding()
					Spacer()
				}
				HStack {
					Text("Answers")
						.font(.title)
						.padding(.leading)
					Spacer()
				}
				if question.getAnswers().count == 0 {
					HStack {
						Text(noAnswerString)
							.padding()
							.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
							.cornerRadius(10)
							.padding()
						Spacer()
					}
				} else {
					ForEach(question.getAnswers(), id: \.self) { answer in
						HStack {
							Text(answer)
								.padding()
								.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
								.cornerRadius(10)
								.padding()
							Spacer()
						}
					}
				}
				
				if answeringQuestion {
					HStack {
						Text("Your Answer")
							.font(.title)
							.padding(.top)
							.padding(.leading)
						Spacer()
					}
					TextEditor(text: $answer)
						.padding()
						.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
						.cornerRadius(10)
						.frame(width: screenWidth * 0.9, height: screenHeight * 0.3, alignment: .center)
						.padding(.trailing)
						.padding(.leading)
				}
				
				HStack {
					Spacer()
					
					if !answeringQuestion {
						Button(action: {
							answeringQuestion = true
						}, label: {
							HStack {
								Text("Answer question")
									.font(.headline)
									.foregroundColor(Color.blue)
								Image(systemName: "keyboard")
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
						.padding()
					} else {
						Button(action: {
							answeringQuestion = false
							question.add(answer: answer)
						}, label: {
							Text("Submit")
								.padding()
								.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
								.cornerRadius(10)
						})
						.padding()
						
						Button(action: {
							answeringQuestion = false
						}, label: {
							Text("stop answering")
								.padding()
								.foregroundColor(.red)
								.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
								.cornerRadius(10)
						})
						.padding()
					}
					
					Spacer()
				}
            }
			.navigationTitle("Post")
        }
    }
    
    struct PostView_Previews: PreviewProvider {
        static var previews: some View {
            PostView(question: Question("random"))
        }
    }
}
