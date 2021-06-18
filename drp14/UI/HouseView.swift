//
//  HouseView.swift
//  drp14
//
//  Created by Frank Fan on 2021/6/18.
//

import SwiftUI

struct HouseView: View {
    @Binding var loggedIn: Bool
    
    var body: some View {
        Text("Everything you want to know about house renting!")
    }
}

struct HouseView_Previews: PreviewProvider {
    static var previews: some View {
        HouseView(loggedIn:.constant(false))
    }
}
