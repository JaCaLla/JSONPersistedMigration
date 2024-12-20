//
//  Person.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//

import Foundation

struct Person: Codable {
    var version: Int {
        return 3
    }
    
    let alias: String
    let email: String
}


extension Person {
    static let sample = Person(alias: "Pedro", email: "pedro.asdt@gmail.com")
}
