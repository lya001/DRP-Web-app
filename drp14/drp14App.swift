//
//  drp14App.swift
//  drp14
//
//  Created by Aris Zhu Yi Qing on 03/06/2021.
//

import SwiftUI
import Firebase

@main
struct drp14App: App {
	
	init() {
		FirebaseApp.configure()
	}
	
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

extension UIApplication {
	func endEditing(_ force: Bool) {
		self.windows
			.filter{$0.isKeyWindow}
			.first?
			.endEditing(force)
	}
}
