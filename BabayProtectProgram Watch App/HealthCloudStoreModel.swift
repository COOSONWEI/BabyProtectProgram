//
//  HealthCloudStoreModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/15.
//


import Foundation
import HealthKit
import CloudKit

class HealthiCloudStore: ObservableObject {
    
    @Published var health: [CKRecord] = []
    
    func fetchRestaurants() async throws {
        // Fetch data using Convenience API
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "HealthData", predicate: predicate)
        
        let results = try await publicDatabase.records(matching: query)
        
        for record in results.matchResults {
            self.health.append(try record.1.get())
        }
        
        print("lalllalalallal")
        DispatchQueue.main.async {
            
                self.health.sort(by: { (record1, record2) -> Bool in
                    guard let creationDate1 = record1.creationDate, let creationDate2 = record2.creationDate else {
                        return false
                    }
                    return creationDate1 > creationDate2
                })
            }
       
    }
    
    func saveRecordToCloud(health: HealthModel) {

        // Prepare the record to save
        let record = CKRecord(recordType: "HealthData")
        record.setValue(health.walkStep, forKey: "walkStep")
//        record.setValue(health.distance, forKey: "distance")
//        record.setValue(health.sleepTime, forKey: "sleepTime")
//        record.setValue(health.heartRate, forKey: "heartRate")

        // Get the Public iCloud Database
        let publicDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").publicCloudDatabase

        // Save the record to iCloud
        publicDatabase.save(record, completionHandler: { (record, error) -> Void  in

            if error != nil {
                print("无法完成保存")
                print(error.debugDescription)
            }

            // Remove temp file
           
        })
    }
    
}


