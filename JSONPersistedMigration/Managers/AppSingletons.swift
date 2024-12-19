//
//  AppSingletons.swift
//  LocationSampleApp
//
//  Created by Javier Calatrava on 1/12/24.
//

import Foundation

@MainActor
struct AppSingletons {
    var userDefaultsManager: UserDefaultsManagerProtocol
    var migrationManager: MigrationManagerProtocol
    
    init(userDefaultsManager: UserDefaultsManager = UserDefaultsManager(),
         migrationManager: MigrationManagerProtocol = MigrationManager()) {
        self.userDefaultsManager = userDefaultsManager
        self.migrationManager = migrationManager
    }
}

@MainActor var appSingletons = AppSingletons()
