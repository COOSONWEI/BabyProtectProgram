//
//  GetBeaconModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/15.
//

import Foundation
import CloudKit

class CloudBeaconModel: ObservableObject {
    
    @Published var beaconNames: [CKRecord] = []
    @Published var usefulBeaconNames: [String:Int] = [:]
    
    func fetchBeacons() async throws {
        // Fetch data using Convenience API
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Beacons", predicate: predicate)
        
        let results = try await publicDatabase.records(matching: query)
        
        for record in results.matchResults {
            self.beaconNames.append(try record.1.get())
        }
        DispatchQueue.main.async {
            
            for beaconName in self.beaconNames {
                self.usefulBeaconNames.updateValue(0, forKey: beaconName.object(forKey: "beaconsName") as! String)
//                print(self.usefulBeaconNames)
            }
           
            
        }
        print("lalllalalallal")
       
    }
    
    func changeBeaconRecordToCloud(beacon: BeaconModel, name: String) {

        //  准备保存
        let record = CKRecord(recordType: "Beacons")
        let predicate = NSPredicate(format: "name = %@", name)
        //查询表中内容
        let query = CKQuery(recordType: "Beacons", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)

        queryOperation.recordFetchedBlock = { record in
            // 在这里处理每个记录
            // 访问记录的字段并修改它们
            record["near"] = 1 // 设置新的 touched 值
        }
        
        
        queryOperation.queryCompletionBlock = { cursor, error in
            if let error = error {
                // 处理错误
            } else {
                // 完成查询操作，可以在这里执行保存操作
                let publicDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").publicCloudDatabase
                //处理成功
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
        

        
    }
    func saveNewBeaconToCloud(beaconModel: BeaconModel) {
//        print("contact Name: \(contact.name)")
        // Prepare the record to save
        let record = CKRecord(recordType: "Beacons")
        record.setValue(beaconModel.beaconName.name, forKey: "beaconsName")
      
        // Get the Public iCloud Database
        let publicDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").publicCloudDatabase

        // Save the record to iCloud
        publicDatabase.save(record, completionHandler: { (record, error) -> Void  in
            if error != nil {
                print("无法完成保存")
                print(error.debugDescription)
            }else{
                print("联系人储存成功")
            }

            // Remove temp file
           
        })
    }

    
}


