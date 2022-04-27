//
//  AccountsRepositoryImplementation.swift
//  Zadatak1
//
//  Created by David Horvat on 27.04.2022..
//

import Foundation

class AccountsRepositoryImpl: AccountsRepository {

    func getAccounts() -> Result<Accounts, AppError> {
        return RestManager.parseFromDefaultFile()
    }
}
