//
//  SafeGuardApp.swift
//  SafeGuard
//
//  Created by ISLAZAREV on 22.06.2022.
//

import SwiftUI

@main
struct SafeGuardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(CameraManager.shared)
        }
    }
}
