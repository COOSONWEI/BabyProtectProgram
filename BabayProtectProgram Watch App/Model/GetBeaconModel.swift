//
//  GetBeaconModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/15.
//

import Foundation
import CloudKit

class BeaconModel: ObservableObject {
    
    @Published var beaconNames: [CKRecord] = []
    @Published var usefulBeaconNames: [String] = []
    
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
                self.usefulBeaconNames.append(beaconName.object(forKey: "beaconsName") as! String )
                print(self.usefulBeaconNames)
            }
           
            
        }
        print("lalllalalallal")
       
    }
}


