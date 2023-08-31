//
//  NotificationModel.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import Foundation
import CloudKit
import UserNotifications
import UIKit

class CloudPushNotificationViewModel:  ObservableObject {
    
    //请求通知权限
    func requestNotification() {
        let options: UNAuthorizationOptions = [.alert, .badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }else if success {
                print("Notification permmissions success!")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            }else{
                print("Notification permmissions failure.")
            }
        }
    }
    
    func sendNotification(title: String, subtitle: String ,body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        print("i send an notification")
        UNUserNotificationCenter.current().add(request)
        
    }
    
    //订阅通知
    func subscribeToNotificatoin() {
        
        let predicate = NSPredicate(value: true)
        //订阅通知的方式
        let subscription = CKQuerySubscription(recordType: "Beacons", predicate: predicate, subscriptionID: "chailds_near", options: .firesOnRecordUpdate)
        let geoFencationSubsciption = CKQuerySubscription(recordType: "GeoDangers", predicate: predicate, subscriptionID: "child_near_geofencations",options: .firesOnRecordCreation)
        
        //订阅室内危险区通知
        let notification = CKSubscription.NotificationInfo()
        notification.title = "您的孩子接近危险物品！！！"
        notification.alertBody = "是否要打开App给孩子打个电话确认情况？"
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        
        //订阅地理围栏
        let geoNotifation = CKSubscription.NotificationInfo()
        geoNotifation.title = "您的孩子在危险水域附近！！！"
        geoNotifation.alertBody = "是否要打开App查看孩子位置和情况？"
        geoNotifation.soundName = "default"
        
        geoFencationSubsciption.notificationInfo = geoNotifation
        
        CKContainer.default().privateCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error.localizedDescription)
            }else {
                print("Successful subscribed to notification")
            }
        }
        
        CKContainer.default().privateCloudDatabase.save(geoFencationSubsciption) { returnedSubscription, returnError in
            if let error = returnError {
                print(error.localizedDescription)
            }else{
                print("Successful subscribed to GeoNotificaiton")
            }
        }
        
    }
    
    //取消通知
    func unsubscribeToNotification() {
        CKContainer.default().privateCloudDatabase.delete(withSubscriptionID: "child_enter_geofencations") { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error.localizedDescription)
            }else {
                print("Successful unSubscribed!")
            }
        }
    }
    
    func fetchSubscriptions(completion: @escaping ([CKSubscription.ID: CKSubscription]?, Error?) -> Void) {
        let operation = CKFetchSubscriptionsOperation(subscriptionIDs: ["chailds_near","child_near_geofencations"])
        
        operation.fetchSubscriptionCompletionBlock = { subscriptionsByID, error in
            completion(subscriptionsByID, error)
        }
        
        CKContainer.default().privateCloudDatabase.add(operation)
    }
    
    // 调用上述方法来获取用户订阅信息
    

}



