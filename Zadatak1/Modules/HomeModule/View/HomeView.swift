//
//  HomeView.swift
//  Zadatak1
//
//  Created by David Horvat on 20.04.2022..
//

import Foundation
import UIKit

class HomeView: UIView {
    var onRegisterButtonTapped: (() -> Void)?

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Components
    
    lazy var createPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.sizeToFit()
        addSubview(label)
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        button.layer.cornerRadius = 30
        addSubview(button)
        return button
    }()
    
    lazy var enterPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.sizeToFit()
        addSubview(textField)
        return textField
    }()
    

    @objc func registerTapped() {
        onRegisterButtonTapped?()
    }
    
    func reloadView(isLogin: Bool) {
        isLogin ? registerButton.setTitle("Login", for: .normal) : registerButton.setTitle("Register", for: .normal)
        isLogin ? (createPasswordLabel.text = "Login with password") : (createPasswordLabel.text = "Create new password")
        enterPasswordTextField.text = ""
    }
}

//MARK: - Extension

private extension HomeView {
    func setup() {
        backgroundColor = .orange
     
        createPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        enterPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            createPasswordLabel.centerXAnchor.constraint(equalTo: enterPasswordTextField.centerXAnchor),
            createPasswordLabel.bottomAnchor.constraint(equalTo: enterPasswordTextField.topAnchor, constant: -75),

            enterPasswordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            enterPasswordTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            registerButton.topAnchor.constraint(equalTo: enterPasswordTextField.bottomAnchor, constant: 75),
            registerButton.centerXAnchor.constraint(equalTo: enterPasswordTextField.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 80)

        ])
    }
}

