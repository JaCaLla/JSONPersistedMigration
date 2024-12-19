//
//  Person.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//

import Foundation

struct Person: Codable {
    let name: String
    let age: String
}


extension Person {
    static let sample = Person(name: "Pedro", age: "24")
}
