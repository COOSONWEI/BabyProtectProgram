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
    @Published var healthData = HealthModel()
    @Published var walkStep = 0
    @Published var distance: Double = 0.0
    @Published var sleepTime: Double = 0.0
    @Published var heartRate: Int = 0
    
    func startFetch()  {
            // 创建定时器，每隔一段时间触发一次查询操作
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                self.fetchHealthdata()
            }
            fetchHealthdata() // 立即执行一次查询
    }
    
    
     func fetchRestaurants() async throws {
        // Fetch data using Convenience API
         let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "HealthData", predicate: predicate)
        
        let results = try await publicDatabase.records(matching: query)
        
        for record in results.matchResults {
            self.health.append(try record.1.get())
        }
        
        
         print("lalllalalallal:\(health.count)")
        DispatchQueue.main.async {
                self.health.sort(by: { (record1, record2) -> Bool in
                    guard let creationDate1 = record1.creationDate, let creationDate2 = record2.creationDate else {
                        return false
                    }
                    print(creationDate1)
                    return creationDate1 > creationDate2
                })
            
           
            if !self.health.isEmpty, let latestRecord = self.health.first {
                self.walkStep = latestRecord.object(forKey: "walkStep") as? Int ?? 0
                self.distance = latestRecord.object(forKey: "distance") as? Double ?? 0.0
                self.heartRate = latestRecord.object(forKey: "heartRate") as? Int ?? 0
                self.sleepTime = latestRecord.object(forKey: "sleepTime") as? Double ?? 0.0
                
                print("healthCount: \(self.health.count)")
                print("Latest health data:")
                print("walkStep: \(self.walkStep)")
                print("distance: \(self.distance)")
                print("heartRate: \(self.heartRate)")
                print("sleepTime: \(self.sleepTime)")
            } else {
                print("No health data available or empty array.")
            }
            
        }
//         print(health)
////         walkStep = self.health.first?.object(forKey: "walkStep") as! Int
//         print("health.count\(self.health.count)")
    }
    
    func fetchHealthdata() {
       // Fetch data using Convenience API
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
       let publicDatabase = cloudContainer.privateCloudDatabase
       let predicate = NSPredicate(value: true)
       let query = CKQuery(recordType: "HealthData", predicate: predicate)
       
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) in
                if let error = error {
                    print("Error fetching data from CloudKit: \(error.localizedDescription)")
                } else if let results = results {
                    DispatchQueue.main.async {
                        self.health = results
                        print("lalllalalallal")
                        self.health.sort(by: { (record1, record2) -> Bool in
                            guard let creationDate1 = record1.creationDate, let creationDate2 = record2.creationDate else {
                                return false
                            }
                            return creationDate1 > creationDate2
                        })
                        print("healthCounttt:(\(self.health)")
                    }
                }
            }
   }
    func saveRecordToCloud(health: HealthModel) {
        
        // Prepare the record to save
        let record = CKRecord(recordType: "HealthData")
        record.setValue(health.walkStep, forKey: "walkStep")
        record.setValue(health.distance, forKey: "distance")
        record.setValue(health.sleepTime, forKey: "sleepTime")
        record.setValue(health.heartRate, forKey: "heartRate")
        record.setValue(health.RestingHeartRate, forKey: "restingHeartRate")
        record.setValue(health.todayCalorie, forKey: "todayCalorie")
        record.setValue(health.todayTime, forKey: "todayTime")
        
        
        // Get the Public iCloud Database
        let publicDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").privateCloudDatabase

        // Save the record to iCloud
        publicDatabase.save(record, completionHandler: { (record, error) -> Void  in

            if error != nil {
                print("无法完成保存")
                print(error.debugDescription)
            }else{
                print("健康数据储存成功")
            }
            
            // Remove temp file
           
        })
    }
    
}


