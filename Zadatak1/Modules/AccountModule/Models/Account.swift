//
//  AccountsModel.swift
//  Zadatak1
//
//  Created by David Horvat on 22.04.2022..
//

import Foundation

struct Account: Codable {
    var id: String
    var IBAN: String
    var amount: String
    var currency: String
    var transactions: [Transactions]
}
