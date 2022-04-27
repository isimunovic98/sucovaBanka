//
//  Repository.swift
//  Zadatak1
//
//  Created by David Horvat on 23.04.2022..
//

import Foundation

class Repository {
    
    static func loadJson(from filename: String) -> Accounts? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Accounts.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
