//
//  MigrationManager.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//

import Foundation

@MainActor
protocol MigrationManagerProtocol {
    func applyMigration()
}

@MainActor
final class MigrationManager: ObservableObject {
    @Published var migrationPenging = true
    @Published var migrationFailed = false
    
    struct PersonV0: Codable {
        let name: String
        let age: String
    }
    
    typealias PersonV1 = Person
}

extension MigrationManager: MigrationManagerProtocol {
    func applyMigration() {
        defer { migrationPenging = false }
        applyPersonMigration()
    }
    
    private func isPersonMigrationPending() -> Bool {
        let userDefaultsManager = appSingletons.userDefaultsManager
        return userDefaultsManager.get(Person.self, forKey: UserDefaultsManager.key.person) == nil
    }
    
    private func applyPersonMigration() {
        let userDefaultsManager = appSingletons.userDefaultsManager

        guard isPersonMigrationPending() else {
            return // No migration needed
        }
        let currentStoredPersonVersion = storedPersonVersion()
        if currentStoredPersonVersion == 0,
            let personV0 = userDefaultsManager.get(PersonV0.self, forKey: UserDefaultsManager.key.person) {
            let person = PersonV1(name: personV0.name, age: personV0.age, email: "---")
            saveInUserDefaults(person, UserDefaultsManager.key.person, &migrationFailed)
        }
    }
    
    private func storedPersonVersion() -> Int {
            return 0
    }
    
    private func saveInUserDefaults<T: Codable>(_ person: T,_ key: String,_ migrationFailed: inout Bool) {
        let userDefaultsManager = appSingletons.userDefaultsManager
        do {
            try userDefaultsManager.set(person, forKey: key)
        } catch {
            migrationFailed = true
        }
        if isPersonMigrationPending() {
            migrationFailed = true
            return // No migration needed
        }
    }
}
