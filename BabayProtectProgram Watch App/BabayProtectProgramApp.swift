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
    @StateObject private var locationModel = LocationModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuView(healthModel: healthModel,locationModel: locationModel)
//                ICloudTest(healModel: healthModel)
                    .onAppear {
                        healthModel.requestHealthKitPermissions()
                        healthModel.fetchSleepData()
                        healthModel.fetchTodayStepCount()
                        healthModel.fetchStaticHeartRate()
                        healthModel.fetchCurrentHeartRate()
                        healthModel.fetchWalkoutTimeAndEnage()
                        healthModel.fetchDistancofWalkAndRuning()
                        locationModel.checkIfLocationServiesIsEnabled()
                        locationModel.checkLocationAuthorization()
                    }
            }
           
        }
        
    }
}
