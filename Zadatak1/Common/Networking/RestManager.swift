//
//  RestManager.swift
//  Zadatak1
//
//  Created by David Horvat on 27.04.2022..
//

import Foundation

class RestManager {
    static func parseFromDefaultFile() -> Result<Accounts,AppError>{
        if let decoded: Accounts = SerializationManager.parseFromFile(named: "accounts") {
            return .success(decoded)
        } else {
            return .failure(.parseFailed)
        }
    }
}
