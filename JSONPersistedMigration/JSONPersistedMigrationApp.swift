//
//  JSONPersistedMigrationApp.swift
//  JSONPersistedMigration
//
//  Created by Javier Calatrava on 18/12/24.
//
#if DEBUG
    import DebugSwift
#endif

import SwiftUI

@main
struct JSONPersistedMigrationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
#if DEBUG
                    setupDebugSwift()
#endif
                }
                .onShake {
#if DEBUG
                    DebugSwift.show()
#endif
                }
                .task {
                    appSingletons.migrationManager.applyMigration()
                }
        }
    }
    
    fileprivate func setupDebugSwift() {
        DebugSwift
            .setup()


        // MARK: Leak Detector

        DebugSwift.Performance.LeakDetector.onDetect { data in
            // If you send data to some analytics
            print(data.message)
        }

        // MARK: - Custom Controllers

        // MARK: - Enable/Disable Debugger
        DebugSwift.Debugger.logEnable = true
        DebugSwift.Debugger.feedbackEnable = true
    }
}
