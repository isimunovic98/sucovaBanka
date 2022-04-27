//
//  HomeViewModel.swift
//  Zadatak1
//
//  Created by David Horvat on 25.04.2022..
//

import Foundation
import UIKit

class HomeViewModel {
    weak var coordinatorDelegate: HomeCoordinatorDelegate?
    static private let key = "home"
    var homeModel: HomeModel = HomeModel()
    
    func openAccountsList() {
        coordinatorDelegate?.openAccountsList()
    }
}

//MARK: - Extension

extension HomeViewModel {
    
    func saveToUserDefaults() {
        do {
            let data = try JSONEncoder().encode(homeModel)
            UserDefaults.standard.setValue(data, forKey: Self.key)
        } catch {
            fatalError("Error while saving to user defaults")
        }
    }
    
    func loadFromUserDefaults() {
        if let saved = UserDefaults.standard.value(forKey: Self.key) as? Data {
            let jsonDecoder = JSONDecoder()
            do{
                let savedModel = try jsonDecoder.decode(HomeModel.self, from: saved)
                self.homeModel = savedModel
                
            } catch{
                fatalError("Couldn't decode saved settings")
            }
        }
        else {
            self.homeModel = HomeModel()
        }
    }
}
