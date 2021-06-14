//
//  AddTagView.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 14/06/2021.
//

import SwiftUI

struct AddTagView: View {
	
	@Environment(\.presentationMode) var presentationMode
	@Binding var tags: [String]
	@State var tag = ""
	
    var body: some View {
		VStack {
			TextField("Tag", text: $tag)
				.padding()
				.background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
				.cornerRadius(10)
				.padding()
			
			Button(action: {
				// strip off extra spaces at the front and back, and in between the words of the tag string
				tag = tag.components(separatedBy: .whitespaces).filter({!$0.isEmpty}).joined(separator: " ")
				if tag != "" {
					tags.append(tag)
				}
				presentationMode.wrappedValue.dismiss()
			}, label: {
				HStack {
					Text("Add tag")
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
    }
}

struct AddTagView_Previews: PreviewProvider {
    static var previews: some View {
		AddTagView(tags: .constant(["Hello", "World", "!"]))
    }
}
