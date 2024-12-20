//
//  JSONPersistedMigrationTests.swift
//  JSONPersistedMigrationTests
//
//  Created by Javier Calatrava on 18/12/24.
//

import Testing
@testable import JSONPersistedMigration

struct JSONPersistedMigrationTests {

    @Test
    @MainActor
    func migrationFromV0To3() throws {
        // Given: When we are in version 0
                    let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.reset()
        let personV0 = MigrationManager.PersonV0(name: "Peter", age: "55")
        do {
            try userDefaultsManager.set(personV0, forKey: UserDefaultsManager.key.person)
        } catch {
            #expect(Bool(false))
        }
        // When
        let sut = MigrationManager()
        sut.applyMigration()
        
        let retrievedPerson = userDefaultsManager.get(Person.self, forKey: UserDefaultsManager.key.person)
        

        #expect(retrievedPerson?.alias == "Peter")
        #expect(retrievedPerson?.email == "---")
    }
    
    @Test
    @MainActor
    func migrationFromV1To3() throws {
        // Given: When we are in version 0
                    let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.reset()
        let personV1 = MigrationManager.PersonV1(name: "Peter", age: "55", email: "peter@example.com")
        do {
            try userDefaultsManager.set(personV1, forKey: UserDefaultsManager.key.person)
        } catch {
            #expect(Bool(false))
        }
        // When
        let sut = MigrationManager()
        sut.applyMigration()
        
        let retrievedPerson = userDefaultsManager.get(Person.self, forKey: UserDefaultsManager.key.person)
        

        #expect(retrievedPerson?.alias == "Peter")
        #expect(retrievedPerson?.email == "peter@example.com")
    }
    
    @Test
    @MainActor
    func migrationFromV2To3() throws {
        // Given: When we are in version 0
                    let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.reset()
        let personV1 = MigrationManager.PersonV2(alias: "Peter", age: "55", email: "peter@example.com")
        do {
            try userDefaultsManager.set(personV1, forKey: UserDefaultsManager.key.person)
        } catch {
            #expect(Bool(false))
        }
        // When
        let sut = MigrationManager()
        sut.applyMigration()
        
        let retrievedPerson = userDefaultsManager.get(Person.self, forKey: UserDefaultsManager.key.person)
        

        #expect(retrievedPerson?.alias == "Peter")
        #expect(retrievedPerson?.email == "peter@example.com")
    }
}

