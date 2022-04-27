//
//  SerializationManager.swift
//  Zadatak1
//
//  Created by David Horvat on 27.04.2022..
//

import Foundation

class SerializationManager {
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    static func parseFromFile<T: Codable>(named filename: String) -> T?  {
        var object: T?
        do {
            guard let file = Bundle.main.url(forResource: filename, withExtension: "json"),
                  let jsonData = try? Data(contentsOf: file) else {
                return object
            }
            if let decoded: T = parse(jsonData: jsonData) {
                object = decoded
            }
            
            return object
        }
    }

    
    static func parse<T:Codable>(jsonData: Data) -> T? {
        let object: T?
        do {
            object = try decoder.decode(T.self, from: jsonData)
        } catch {
            object = nil
        }
        
        return object
        
    }
    
    
}
