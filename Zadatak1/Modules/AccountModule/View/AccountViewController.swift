//
//  AccountViewController.swift
//  Zadatak1
//
//  Created by David Horvat on 20.04.2022..
//

import UIKit

class AccountViewController: UIViewController {
    
    var coordinator: Coordinator?
    let viewModel: AccountsViewModel
    private lazy var accountView = AccountView()
    //let style = ToastStyle()
    
    //MARK: - Init
    
    init(viewModel: AccountsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        //self.accountView.makeToast("Error while loading data: ", duration: 2.0, position: .center, style: style)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addCallbacks()
        if viewModel.screenData.acounts.count > 0 {
            self.setStartingAccount()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            viewModel.coordinatorDelegate?.viewControllerDidFinish()
        }
    }

    
    
    
    override func loadView() {
        self.view = accountView
    }
}

//MARK: - Extension

extension AccountViewController {
    
    @objc func logOut() {
        viewModel.coordinatorDelegate?.viewControllerDidFinish()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOut))
    }
    
    private func addCallbacks() {
        
        self.viewModel.setTitle = { [unowned self] title in
            self.accountView.chooseIbanButton.setTitle("IBAN(\(title))", for: .normal)
        }
        
        self.accountView.onChooseIBANTapped = { [unowned self] in
            self.viewModel.callAlertController(on: self)
        }
        
        self.viewModel.dataNotFound = { [unowned self] error in
            
            //self.accountView.makeToast("Error while loading data: \(error)", duration: 2.0, position: .center, style: style)
            
        }
        
        self.viewModel.setupData = { [unowned self] sections in
            self.accountView.setupData(sections: sections)
            DispatchQueue.main.async {
                self.accountView.transactionsTable.reloadData()
            }
        }
    }
    
    private func setStartingAccount() {
        self.accountView.chooseIbanButton.setTitle("IBAN(\(IBAN.HRK.rawValue))", for: .normal)
        self.accountView.setupData(sections: MonthSection.groupTransactions(transactions: viewModel.screenData.acounts[0].transactions))
        DispatchQueue.main.async {
            self.accountView.transactionsTable.reloadData()
        }
    }
}
