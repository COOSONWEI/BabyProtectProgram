//
//  MapViewModel.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import Foundation
import MapKit
import SwiftUI
import CloudKit
import CoreLocation

//地图位置的数据结构(经纬度坐标)
struct MapLocation {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var street_name: String
}
//最新同步的位置经纬度
class LastLocation: ObservableObject {
    @Published var location = MapLocation(latitude: 0.0, longitude: 0.0,street_name: "上海南站")
}

//获取iCloud上的数据(遵循ObservableObject协议)
class LocationCloudStroe: ObservableObject {
    //公开发布数据
    @Published var locationRecord: [CKRecord] = []
    @StateObject var lastLocation = LastLocation()
    
    //匹配数据从云端
    func fetchRecord() async throws {
        // 从云端匹配数据
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "CoreLocations", predicate: predicate)
        
        let results = try await publicDatabase.records(matching: query)
        
        for record in results.matchResults {
            self.locationRecord.append(try record.1.get())
        }
        
        let sortedRecords = locationRecord.sorted { (record1, record2) -> Bool in
                guard let creationDate1 = record1.creationDate,
                      let creationDate2 = record2.creationDate else {
                    return false
                }
                return creationDate1 > creationDate2
            }
        //获取按时间排好序的位置信息
        self.locationRecord = sortedRecords
        
        //将最新的数据存储到另一个数组中（通过主线程来完成该操作）
        DispatchQueue.main.async {
            self.lastLocation.location.latitude = self.locationRecord[0].object(forKey: "latitude") as! CLLocationDegrees
            self.lastLocation.location.longitude = self.locationRecord[0].object(forKey: "longitude") as! CLLocationDegrees
            self.lastLocation.location.street_name = self.locationRecord[0].object(forKey: "street_name") as! String
            
        }
        print("lalllalalallal")
    }
    //发布数据存储到iCloud中
    func saveRecordToCloud(location: LastLocation) {
//        print("contact Name: \(contact.name)")
        // Prepare the record to save
        let record = CKRecord(recordType: "CoreLocations")
        record.setValue(String(location.location.latitude), forKey: "latitude")
        record.setValue(String(location.location.longitude), forKey: "longitude")
        record.setValue(String(location.location.street_name), forKey: "street_name")
        
        // Get the Public iCloud Database
        let publicDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").publicCloudDatabase

        // Save the record to iCloud
        publicDatabase.save(record, completionHandler: { (record, error) -> Void  in
            
            if error != nil {
                print("无法完成保存")
                print(error.debugDescription)
                
            }else{
                print("位置储存成功")
            }

            // Remove temp file
           
        })
    }
}
