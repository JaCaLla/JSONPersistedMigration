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
    func migrationFromV0ToV1() throws {
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
        
        #expect(retrievedPerson?.name == "Peter")
        #expect(retrievedPerson?.age == "55")
        #expect(retrievedPerson?.email == "---")
    }

}
