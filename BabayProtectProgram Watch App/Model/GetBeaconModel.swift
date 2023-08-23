//
//  GetBeaconModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/15.
//

import Foundation
import CloudKit


struct BeaconsDataModel {
    let beaconsName: String
    let near: Int
}

class BeaconViewModel: ObservableObject {
    
    @Published var beacons = BeaconsDataModel(beaconsName: "", near: 0)
    
}

class CloudBeaconModel: ObservableObject {
    
    @Published var beaconNames: [CKRecord] = []
    @Published var usefulBeaconNames: [String:Int] = [:]
    @Published var usefulbeaconsubTitle: [String:String] =  [:]
    
    func fetchBeacons() async throws {
        // Fetch data using Convenience API
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Beacons", predicate: predicate)
        
        let results = try await publicDatabase.records(matching: query)
        
        for record in results.matchResults {
            self.beaconNames.append(try record.1.get())
        }
        
        DispatchQueue.main.async {
            
            for beaconName in self.beaconNames {
                
                self.usefulBeaconNames.updateValue(0, forKey: beaconName.object(forKey: "beaconsName") as! String)
//                self.usefulbeaconsubTitle.updateValue(beaconName.object(forKey: "subName") as! String, forKey: beaconName.object(forKey: "beaconsName") as! String)
            }
            
        }
        print("lalllalalallal")
        
    }
    
    func changeBeaconRecordToCloud(beacon: BeaconModel, name: String) {
        
        // Prepare the record to save
        let record = CKRecord(recordType: "Beacons")
        record.setValue(beacon.beaconName.name, forKey: "beaconsName")
        record.setValue(1, forKey: "near")
        
        // Get the Public iCloud Database
        let publicDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").privateCloudDatabase
        
        // Save the record to iCloud
        publicDatabase.save(record, completionHandler: { (record, error) -> Void  in
            if error != nil {
                print("无法完成保存")
                print(error.debugDescription)
            }else{
                print("信标储存成功")
            }
            
            // Remove temp file
            
        })
    }
    
    func updateBeaconRecord(beaconName: String) async throws {
        // Fetch data using Convenience API
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.privateCloudDatabase
        
        // 构建查询谓词
        let predicate = NSPredicate(format: "beaconsName == %@", beaconName)
        let query = CKQuery(recordType: "Beacons", predicate: predicate)
        
        // 执行查询操作
        let queryResults = try await publicDatabase.records(matching: query)
        
        if let recordToUpdate = queryResults.matchResults.first?.1 {
            // 修改记录中的字段
            switch recordToUpdate {
            case .success(let result):
                result["near"] = 1
               try await publicDatabase.save(result)
                print("Record updated successfully.")
            case .failure(_):
                 print("修改记录失败")
            }
           
        } else {
            print("Record not found.")
        }
    }

    
    func saveNewBeaconToCloud(beaconModel: BeaconModel) {
        //        print("contact Name: \(contact.name)")
        // Prepare the record to save
        let record = CKRecord(recordType: "Beacons")
        record.setValue(beaconModel.beaconName.name, forKey: "beaconsName")
        record.setValue(beaconModel.beaconName.subTitle, forKey: "subName")
        
        record.setValue(0, forKey: "near")
        
        // Get the Public iCloud Database
        let publicDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").privateCloudDatabase
        
        // Save the record to iCloud
        publicDatabase.save(record, completionHandler: { (record, error) -> Void  in
            if error != nil {
                print("无法完成保存")
                print(error.debugDescription)
            }else{
                print("信标储存成功")
            }
            
            // Remove temp file
            
        })
    }
    
    
}


