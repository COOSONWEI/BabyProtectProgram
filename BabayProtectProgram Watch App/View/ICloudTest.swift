//
//  ICloudTest.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/15.
//

import SwiftUI

struct ICloudTest: View {
    @Environment(\.managedObjectContext) var context
    
    @StateObject var healModel: HealthModel
//    @StateObject var healthViewModel = HealthViewModel()
    
    var body: some View {
        VStack {
            Text("sleepTime\(healModel.sleepTime / 60 / 60)小时，\(Int(healModel.sleepTime) % 60)分钟")
            Button {
                save()
            } label: {
                Text("send data to iCloud")
            }
        }
        .padding()
        
    }
    
    private func save() {
       let healthData = HealthModel()
      
        healthData.walkStep = healModel.walkStep!
//        healthData.heartRate = healModel.heartRate!
//        healthData.sleepTime = healModel.sleepTime
        
        do {
            print(" HealthModel Save Scuceess...")
            try context.save()
           
        }catch {
            print("Failed to save the record...")
            print(error.localizedDescription)
        }
        let cloudStore = HealthiCloudStore()
        cloudStore.saveRecordToCloud(health: healthData)
    }
}

struct ICloudTest_Previews: PreviewProvider {
    static var previews: some View {
        ICloudTest(healModel: HealthModel())
    }
}
