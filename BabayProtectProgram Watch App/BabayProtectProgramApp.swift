//
//  BabayProtectProgramApp.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI

@main
struct BabayProtectProgram_Watch_AppApp: App {
    
    @StateObject private var healthModel = HealthModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
//                MenuView(healthModel: healthModel)
                ICloudTest(healModel: healthModel)
                    .onAppear {
                        healthModel.requestHealthKitPermissions()
                        healthModel.fetchTodayStepCount()
                        healthModel.fetchStaticHeartRate()
                        healthModel.fetchCurrentHeartRate()
                        healthModel.fetchSleepData()
                    }
            }
           
           
        }
        
    }
}
