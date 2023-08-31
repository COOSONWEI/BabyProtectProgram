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

class phoneNumberModel: ObservableObject {
    @Published var name = ""
    @Published var phoneNumber = ""
}


//存放数据的数组
class Contacts: ObservableObject {
    
    @Published var contanctsData: [CKRecord] = []
    
    @Published var contacts: [PhoneNumber] = []
    

    //测试用的数据
    let testContacts = [PhoneNumber(name: "", phoneNumber: ""),PhoneNumber(name: "爸爸", phoneNumber: "19184494122"),PhoneNumber(name: "妈妈", phoneNumber: "19184494122"),PhoneNumber(name: "110", phoneNumber: "110")]
    
    func fetchContacts() async throws {

        // Fetch data using Convenience API
        
        CKContainer.default()
        var cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
        let publicDatabase = cloudContainer.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "ContactPerson", predicate: predicate)
        
        let results = try await publicDatabase.records(matching: query)
        
        for record in results.matchResults {
            self.contanctsData.append(try record.1.get())
        }
        
        
        DispatchQueue.main.async {
            for contactData in self.contanctsData {
                if !self.contacts.contains(PhoneNumber(name: contactData.object(forKey: "name") as! String , phoneNumber: contactData.object(forKey: "phone") as! String )) {
                    self.contacts.append(PhoneNumber(name: contactData.object(forKey: "name") as! String , phoneNumber: contactData.object(forKey: "phone") as! String ))
                    print(self.contacts)
                }
            }
            print("fetchPhoneNumber")
        }
    }

    func saveRecordToCloud(contact: phoneNumberModel) {
//        print("contact Name: \(contact.name)")
        // Prepare the record to save
        let record = CKRecord(recordType: "ContactPerson")
        record.setValue(contact.name, forKey: "name")
        record.setValue(contact.phoneNumber, forKey: "phone")
        
        // Get the Public iCloud Database
        let publicDatabase = CKContainer(identifier: "iCloud.com.lsy.shouhu").privateCloudDatabase

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
    
    
    //删除对应的记录
    func deleteContactsNames(_ contactsName: [String]) async {
            let cloudContainer = CKContainer(identifier: "iCloud.com.lsy.shouhu")
            let publicDatabase = cloudContainer.privateCloudDatabase
            
            for beaconName in contactsName {
                // 构建查询谓词
                let predicate = NSPredicate(format: "name == %@", beaconName)
                let query = CKQuery(recordType: "ContactPerson", predicate: predicate)
                
                // 执行查询操作
                do {
                    let queryResults = try await publicDatabase.records(matching: query)
                    print("queryResults.self = \(queryResults.matchResults.count)")
                    if let recordToDelete = try? queryResults.matchResults.first?.1.get() {
                        // 删除记录
                        print("recordToDelete == \(recordToDelete)")
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
                    print("Error querying records for name: \(beaconName), error: \(error)")
                }
            }
        }
    
}


