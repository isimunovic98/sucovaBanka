//
//  Accounts.swift
//  Zadatak1
//
//  Created by David Horvat on 27.04.2022..
//

import Foundation

struct Accounts: Codable {
    var user_id: String
    var acounts: [Account]
    
    init(){
        self.acounts = []
        self.user_id = ""
    }
}
