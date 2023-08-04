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
//        try? Saooti.setApiUrl("https://api.octopus.saooti.com/")
//        Saooti.setOrganisationId("<organization_id>")
//        SaootiUI.bind()
        
        try? Saooti.setApiUrl("https://api.preprod.saooti.org/")
        Saooti.setOrganisationId("0c599ef4-7bf3-4a76-b7ef-4ed7e4d5cd89")
        SaootiUI.bind()

    }
}
