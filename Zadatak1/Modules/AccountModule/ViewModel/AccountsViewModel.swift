//
//  AccountsViewModel.swift
//  Zadatak1
//
//  Created by David Horvat on 22.04.2022..
//

import Foundation
import UIKit

enum IBAN: String, CaseIterable {
    case HRK = "HR123456789012345678901"
    case EUR = "HR222233334444555577771"
    case USD = "HR333334444499999888887"
}

class AccountsViewModel {
    var screenData = Accounts()
    static let file = "accounts"
    let repository: AccountsRepository
    weak var coordinatorDelegate: CoordinatorDelegate?
    
    var setTitle: ((String) -> Void)?
    var setupData: (([MonthSection]) -> Void)?
    var dataNotFound: ((AppError) -> Void)?

    //MARK: - Init
    
    init(repository: AccountsRepository) {
        
        //TODO: - Check if this is okay
        
        self.repository = repository
        loadAccounts()

    }
}

//MARK: - Extension

extension AccountsViewModel {
    
    func logOut() {
        coordinatorDelegate?.viewControllerDidFinish()
    }
    
    func loadAccounts() {
        switch repository.getAccounts() {
        case let .success(accounts):
            self.screenData = accounts
        case let .failure(error):
            dataNotFound?(error)
            print("Error")
            break
        }
    }
    
    func callAlertController(on vc: UIViewController) {
        let ac = UIAlertController(title: "Choose IBAN", message: nil, preferredStyle: .actionSheet)
    
        for i in 0..<screenData.acounts.count {
            ac.addAction(UIAlertAction(title: IBAN.allCases[i].rawValue, style: .default, handler: setIban))
        }
        vc.present(ac,animated: true)
    }
    
    private func setIban(action: UIAlertAction) {
        guard let title = action.title else { return }
        guard let actionTitle = IBAN(rawValue: title) else { return }
        self.setTitle?(actionTitle.rawValue)
        
        switch actionTitle{
        case .HRK:
            self.setupData?(MonthSection.groupTransactions(transactions: self.screenData.acounts[0].transactions))

        case .EUR:
            self.setupData?(MonthSection.groupTransactions(transactions: self.screenData.acounts[1].transactions))
            
        case .USD:
            self.setupData?(MonthSection.groupTransactions(transactions: self.screenData.acounts[2].transactions))
            
        }
    }
}
