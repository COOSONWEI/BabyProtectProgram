//
//  PhoneNumberModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import Foundation
import WatchConnectivity
import CloudKit


//创建一个手机联系人的数据模型
struct PhoneNumber: Hashable {
    let name: String
    let phoneNumber: String
}

//存放数据的数组
class Contacts: ObservableObject {
    
    @Published var contanctsData: [CKRecord] = []
    @Published var contacts: [PhoneNumber] = []
    
    //测试用的数据
    let testContacts = [PhoneNumber(name: "", phoneNumber: ""),PhoneNumber(name: "爸爸", phoneNumber: "19184494122"),PhoneNumber(name: "妈妈", phoneNumber: "19184494122"),PhoneNumber(name: "110", phoneNumber: "110")]
    
    func fetchContacts() async throws {
        // Fetch data using Convenience API
        let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "ContactPerson", predicate: predicate)
        
        let results = try await publicDatabase.records(matching: query)
        
        for record in results.matchResults {
            self.contanctsData.append(try record.1.get())
        }
        DispatchQueue.main.async {
            
            for beaconName in self.contanctsData {
                
                if !self.contacts.contains(PhoneNumber(name: beaconName.object(forKey: "name") as! String , phoneNumber: beaconName.object(forKey: "phone") as! String )) {
                    self.contacts.append(PhoneNumber(name: beaconName.object(forKey: "name") as! String , phoneNumber: beaconName.object(forKey: "phone") as! String ))
                    print(self.contacts)
                }
                
            }
           
            
        }
        
        print("fetchPhoneNumber")
        
    }
}


