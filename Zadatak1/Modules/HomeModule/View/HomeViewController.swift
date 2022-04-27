//
//  HomeViewController.swift
//  Zadatak1
//
//  Created by David Horvat on 20.04.2022..
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel: HomeViewModel
    private lazy var homeView = HomeView()
    
   // private let style = ToastStyle()
    
    //MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life cycle
    override func loadView() {
        self.view = homeView
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadFromUserDefaults()
        addCallbacks()
        manageKeyboard()
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.saveToUserDefaults()
    }
}

//MARK: - Extension

private extension HomeViewController {
    
    //MARK: - Keyboard methods
    
    private func manageKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK: - Callbacks

    private func addCallbacks() {
        homeView.onRegisterButtonTapped = { [weak self] in
            guard let text = self?.homeView.enterPasswordTextField.text else { return }
            self?.checkEnteredPassword(text: text)
        }
        homeView.reloadView(isLogin: viewModel.homeModel.isLogin)
    }
    
    //MARK: - Password check
    
    private func checkEnteredPassword(text: String) {
        if !(text.isEmpty) {
            handlePasswordLenght(text: text)
        } else {
            //view.makeToast("Password field is empty", duration: 1.0, position: .center , style: style)
        }
    }
    
    private func handlePasswordLenght(text: String) {
        if (text.count) >= 4 && (text.count) <= 6 {
            checkScreen(text: text)
        } else {
            //view.makeToast("Password needs to be in range from 4 to 6 digits",duration: 1.5,position: .center, style: style)/
        }
    }
    
    private func checkScreen(text: String) {
        if viewModel.homeModel.isLogin {
            handleLoginScreen(text: text)
        } else {
            handleRegisterScreen(text: text)
        }
    }
    
    private func handleLoginScreen(text: String) {
        if text == self.viewModel.homeModel.password {
            viewModel.openAccountsList()
            self.homeView.endEditing(true)
        } else {
            //view.makeToast("Wrong password", duration: 1.0, position: .center, style: style)
        }
    }
    
    private func handleRegisterScreen(text: String) {
        viewModel.openAccountsList()
        self.viewModel.homeModel.isLogin = true
        self.viewModel.homeModel.password = text
        self.homeView.endEditing(true)
    }
}
