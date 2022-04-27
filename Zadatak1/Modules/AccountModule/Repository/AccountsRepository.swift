//
//  AccountsRepository.swift
//  Zadatak1
//
//  Created by David Horvat on 27.04.2022..
//

import Foundation

protocol AccountsRepository {
    
    func getAccounts() -> Result<Accounts, AppError> 
}
