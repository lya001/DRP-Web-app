//
//  QuestionRowView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI

struct QuestionRowView: View {
	
	var question: Question
	
    var body: some View {
		VStack {
			HStack {
				Text(question.getQuestion())
					.font(.title)
				Spacer()
			}
			HStack {
				Text(getTimeString(question.getTime()))
				Spacer()
			}
		}
		.padding()
    }
	
	func getTimeString(_ time: Date) -> String {
		let formatter = DateFormatter()
		formatter.timeStyle = .medium
		formatter.dateStyle = .short
		return formatter.string(from: time)
	}
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionRowView(question: Question("random"))
    }
}
