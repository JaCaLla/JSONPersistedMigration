//
//  UserDefaultsManagerTests.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//

import Testing
@testable import JSONPersistedMigration

extension JSONPersistedMigrationTests {
    
    func getSut() -> UserDefaultsManager {
        let manager = UserDefaultsManager()
        manager.reset()
        return manager
    }
    
    @Test
    func userDefaultsManager() throws {
        let sut = getSut()
        
        let person = Person(name: "Alice", age: "48", email: "---")
        do {
            try sut.set(person, forKey: UserDefaultsManager.key.person)
        } catch {
            #expect(Bool(false))
        }
        
        let retrievedPerson = sut.get(Person.self, forKey: UserDefaultsManager.key.person)
        
        #expect(retrievedPerson?.name == "Alice")
        #expect(retrievedPerson?.age == "48")
        #expect(retrievedPerson?.email == "---")
    }
}

