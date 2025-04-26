//
//  IcomeAppApp.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 14/04/2025.
//

import SwiftUI
import SwiftData

@main
struct IcomeAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [TransactionModel.self])
        }
    }
}
