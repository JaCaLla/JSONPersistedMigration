//
//  Person.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//

import Foundation

struct Person: Codable {
    var version: Int {
        return 2
    }
    
    let alias: String
    let age: String
    let email: String
}


extension Person {
    static let sample = Person(alias: "Pedro", age: "24", email: "pedro.asdt@gmail.com")
}
