//
//  Person.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//

import Foundation

struct Person: Codable {
    var version: Int {
        return 1
    }
    let name: String
    let age: String
    let email: String
}


extension Person {
    static let sample = Person(name: "Pedro", age: "24", email: "pedro.asdt@gmail.com")
}
