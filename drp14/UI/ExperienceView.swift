//
//  ExperienceView.swift
//  drp14
//
//  Created by Frank Fan on 2021/6/18.
//

import SwiftUI

struct ExperienceView: View {
    @Binding var loggedIn: Bool
    var body: some View {
        Text("Some tips helps you survive from 1st year")
    }
}

struct ExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceView(loggedIn: .constant(false))
    }
}
