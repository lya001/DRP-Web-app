//
//  PostView.swift
//  drp14
//
//  Created by Yuang Li on 10/06/2021.
//

import SwiftUI

struct PostView: View {
    
    var question: Question
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
	private let noDetailString = "No more details provided."
	private let noTagString = "No tags specified for this question."
    
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
