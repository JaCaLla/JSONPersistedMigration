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
    
    init(userDefaultsManager: UserDefaultsManager = UserDefaultsManager()) {
        self.userDefaultsManager = userDefaultsManager
    }
}

@MainActor var appSingletons = AppSingletons()
