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
   
    //发送通知到云端数据库，当云端数据库检测到数据变化了之后发送订阅通知
    func sendTheInformation(locationManager: LocationManager) {
        //保存数据的表类型和其中字段（这里暂时不需要每个危险区的名字和类型）
        //也因为都是水域的标识
        let recorder = CKRecord(recordType: "GeoDanger")
        recorder.setValue(locationManager.reginLocation.isEnter, forKey: "isEnter")
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
