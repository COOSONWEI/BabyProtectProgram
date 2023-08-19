//
//  GeoCloudStoreModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/18.
//

import SwiftUI
import CoreLocation
import UserNotifications
import CloudKit



//创建一个云存储的模型让它能够向云端存储数据，让手机端能够获取通知
class GeoCloudStoreModel: ObservableObject {
    
    @Published var isentry: [CKRecord] = []
    
    func fetchInformation() async throws {
        
        // Fetch data using Convenience API
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "GeoDangers", predicate: predicate)
        
        let results = try await publicDatabase.records(matching: query)
//        print("results is \(results)")
        for record in results.matchResults {
            self.isentry.append(try record.1.get())
        }
        
        print("isentryCount: \(isentry.count)")
        
        DispatchQueue.main.async {
            for beaconName in self.isentry {
                print("\(beaconName.object(forKey: "isEnter"))")
                //                print(self.usefulBeaconNames)
            }
        }
        print("lalllalalallal")
        
//               31.181721835191095, 121.47985322448413
    }
   
    
    //发送通知到云端数据库，当云端数据库检测到数据变化了之后发送订阅通知
    func sendTheInformation(locationManager: LocationManager) {
        //保存数据的表类型和其中字段（这里暂时不需要每个危险区的名字和类型）
        //也因为都是水域的标识
        let recorder = CKRecord(recordType: "GeoDangers")
        recorder.setValue(1, forKey: "isEnter")
        
        let privateDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").privateCloudDatabase
        
        privateDatabase.save(recorder) { recorder, error in
            if error != nil {
                print("无法完成保存")
                print(error.debugDescription)
            }else{
                print("危险数据上传成功")
            }
        }
    }
    
}
