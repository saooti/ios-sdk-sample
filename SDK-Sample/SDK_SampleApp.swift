//
//  SDK_SampleApp.swift
//  SDK-Sample
//
//  Created by Aleksandr Khorobrykh on 13/02/2023.
//

import SwiftUI
import SaootiSDK

@main
struct SDK_SampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        Saooti.setOrganisationId("<organization_id>")
        SaootiUI.bind()
    }
}
