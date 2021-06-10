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
                Text(question.getQuestion())
                    .padding()
                    .background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
                    .cornerRadius(10)
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.3, alignment: .topLeading)
                HStack {
                    Text("Details/Description")
                        .font(.title)
                        .padding(.top)
                        .padding(.leading)
                    Spacer()
                }
                Text(question.getDetail())
                    .padding()
                    .background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
                    .cornerRadius(10)
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.7, alignment: .topLeading)
            }
        }
    }
    
    struct PostView_Previews: PreviewProvider {
        static var previews: some View {
            PostView(question: Question("random"))
        }
    }
}
