//
//  HomeModel.swift
//  Zadatak1
//
//  Created by David Horvat on 21.04.2022..
//

import Foundation

struct HomeModel: Codable {
    var isLogin: Bool
    var password: String?
    
    init() {
        isLogin = false
        password = nil
    }
}
