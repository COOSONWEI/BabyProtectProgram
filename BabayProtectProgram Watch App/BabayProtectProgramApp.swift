//
//  BabayProtectProgramApp.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI

@main
struct BabayProtectProgram_Watch_AppApp: App {
    
    @StateObject  var healthModel = HealthModel()
    @StateObject  var locationModel = LocationModel()

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
//                        healthModel.fetchWalkoutTimeAndEnage()
                        healthModel.fetchDistancofWalkAndRuning()
                        locationModel.checkIfLocationServiesIsEnabled()
                        locationModel.checkLocationAuthorization()
                        DispatchQueue.main.asyncAfter(deadline: .now()+5){
                            sendHealthData()
                        }
                       
                    }
            }
           
        }
        
    }
    
    func sendHealthData() {
        let healthData = HealthModel()
        healthData.walkStep = healthModel.walkStep
        healthData.distance = healthModel.distance
        healthData.heartRate = healthModel.heartRate
        healthData.RestingHeartRate = healthModel.RestingHeartRate
        healthData.sleepTime = healthModel.sleepTime
//        healthData.todayCalorie = healthModel.todayCalorie
//        healthData.todayTime = healthModel.todayTime
        
        print("healthDate:\(healthModel.heartRate)")
        
        let healthCloudStore = HealthiCloudStore()
        healthCloudStore.saveRecordToCloud(health: healthData)
        print("send health data")
//        print("healthdata: \(healthData.walkStep),\(healthData.distance ),\(healthData.heartRate  ),\(healthData.RestingHeartRate ),\(healthData.sleepTime),\(healthData.todayCalorie ),\(healthData.todayTime)")
    }
}
