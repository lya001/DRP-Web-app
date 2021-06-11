//
//  UserInfo.swift
//  drp14
//
//  Created by 钱行之 on 2021/6/10.
//

import Foundation
import Firebase

struct UserInfo: Equatable, Identifiable, Hashable {
    var id: UUID
    private var username, password: String
    
    public init(withUsername username: String, withPassword password: String, withID id: UUID) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    func getUserName() -> String {
        return self.username
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func writeToDB() {
        Database.database().reference().child("userInfo/\(id.uuidString)").setValue([
            "userName": username,
            "password": password
        ])
    }
}

