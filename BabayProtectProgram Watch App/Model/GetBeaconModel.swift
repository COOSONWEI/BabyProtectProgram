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
    
    private var timer: Timer?
    //轮询数据
    func startLoop() async {
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            
            Task{
                do{
                    try await self?.fetchBeacons()
                    
                } catch {
                    print("loading Error")
                }
            }
        }
        
    }
    
    
    
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
        
        print("beaconNames\(beaconNames)")
        
        DispatchQueue.main.async {
            
            for beaconName in self.beaconNames {
                
                self.usefulBeaconNames.updateValue(beaconName.object(forKey: "near") as! Int, forKey: beaconName.object(forKey: "beaconsName") as! String)
                
                if beaconName.object(forKey: "subName") as? String != nil {
                    self.usefulbeaconsubTitle.updateValue(beaconName.object(forKey: "subName") as! String, forKey: beaconName.object(forKey: "beaconsName") as! String)
                    print("usefulbeaconsubTitle\(self.usefulbeaconsubTitle)")
                }
                
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
                print("resultName = \(result.object(forKey: "beaconsName") as! String )")
                print("resultNear = \(result.object(forKey: "near") as! Int )")
                do {
                    try await publicDatabase.save(result) // 使用 await 等待保存操作完成
                    print("Record updated successfully.")
                } catch {
                    print("save False: \(error)")
                }
                
                // 构建谓词，排除当前记录
                let excludePredicate = NSPredicate(format: "beaconsName != %@", beaconName)
                let excludeQuery = CKQuery(recordType: "Beacons", predicate: excludePredicate)
                
                // 执行查询操作
                let excludeQueryResults = try await publicDatabase.records(matching: excludeQuery)
                
                // 批量修改其他记录的 near 属性为 0
                for (_, excludeResult) in excludeQueryResults.matchResults {
                    switch excludeResult {
                    case .success(let excludeRecord):
                        excludeRecord["near"] = 0
                        try await publicDatabase.save(excludeRecord)
                        print("Other record updated successfully.")
                    case .failure(_):
                        print("修改其他记录失败")
                    }
                }
                
            case .failure(let error):
                print("修改记录失败: \(error)")
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
    
    //删除对应的记录
    func deleteBeaconsWithNames(_ beaconNames: [String]) async {
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.privateCloudDatabase
        
        for beaconName in beaconNames {
            // 构建查询谓词
            let predicate = NSPredicate(format: "beaconsName == %@", beaconName)
            let query = CKQuery(recordType: "Beacons", predicate: predicate)
            
            // 执行查询操作
            do {
                let queryResults = try await publicDatabase.records(matching: query)
                if let recordToDelete = try? queryResults.matchResults.first?.1.get() {
                    // 删除记录
                    do {
                        
                        try await publicDatabase.deleteRecord(withID: recordToDelete.recordID)
                        
                        print("Record deleted successfully for beacon: \(beaconName)")
                    } catch {
                        print("Failed to delete record for beacon: \(beaconName), error: \(error)")
                    }
                } else {
                    print("Record not found for beacon: \(beaconName)")
                }
            } catch {
                print("Error querying records for beacon: \(beaconName), error: \(error)")
            }
        }
    }
    
    
}


