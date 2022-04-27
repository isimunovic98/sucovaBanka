//
//  AccountView.swift
//  Zadatak1
//
//  Created by David Horvat on 21.04.2022..
//

import UIKit

class AccountView: UIView {

    private var sections = [MonthSection]()
    var onChooseIBANTapped: (() -> Void)?
    var onLogoutTapped: (() -> Void)?
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Components
    
    lazy var transactionsTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        addSubview(tableView)
        return tableView
    }()
    
    lazy var chooseIbanButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(chooseIbanButtonTapped), for: .touchUpInside)
        addSubview(button)
        return button
        
    }()

}

//MARK: - Extensions

extension AccountView {
    
    func setupData(sections: [MonthSection]) {
        self.sections = sections
    }
    
    @objc func chooseIbanButtonTapped() {
        onChooseIBANTapped?()
    }
    
    @objc func logOut() {
        onChooseIBANTapped?()
    }
    
    func setup() {
        
        backgroundColor = .white
        
        chooseIbanButton.translatesAutoresizingMaskIntoConstraints = false
        transactionsTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chooseIbanButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            chooseIbanButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            chooseIbanButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            chooseIbanButton.heightAnchor.constraint(equalToConstant: 50),

            transactionsTable.topAnchor.constraint(equalTo: chooseIbanButton.bottomAnchor),
            transactionsTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            transactionsTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            transactionsTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension AccountView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        let section = self.sections[indexPath.section]
        let transaction = section.transactions[indexPath.row]
        
        cell.textLabel?.text = transaction.amount
        cell.detailTextLabel?.text = transaction.description
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        
        return section.transactions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        let date = section.month
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
}

