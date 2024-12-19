//
//  UserDefaultsManager.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func set<T: Codable>(_ value: T, forKey key: String) throws
    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T?
    func reset()
}


final class UserDefaultsManager {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaultsManager: UserDefaultsManagerProtocol {
    
    enum key {
        static let person = "person"
    }
    
    func set<T: Codable>(_ value: T, forKey key: String) throws {
        
        let encodedData = try JSONEncoder().encode(value)
        if let jsonString = String(data: encodedData, encoding: .utf8) {
            UserDefaults.standard.set(jsonString, forKey: key)
        }
    }
    
    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {

        guard let jsonString = UserDefaults.standard.string(forKey: key),
              let jsonData = jsonString.data(using: .utf8)  else {
            return nil
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: jsonData)
            return decoded
        } catch {
            return nil
        }
    }
    
    func reset() {
        for key in userDefaults.dictionaryRepresentation().keys {
            userDefaults.removeObject(forKey: key)
        }
    }
}
