//
//  Datamanager.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/19.
//

import Foundation
import CoreLocation


//数据类型
class DataInfo: ObservableObject {
    @Published var firstOpen = 0
    @Published var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
}


class DataManager {
    //是否是第一次运行
    static func isFirstRuning() -> Bool {
        let dataFilePath: String = NSHomeDirectory() + "/Documents/location_data.plist"
        
        if FileManager.default.fileExists(atPath: dataFilePath) {
            print("\(dataFilePath) 存在，不是第一次打开程序")
            return false
        }
        //如果该文件不存在，那么就在本地的沙盒创建它
        print("\(dataFilePath) 不存在，判断为第一次打开程序，文件已创建完毕")
        let dataInfo = DataInfo()
        dataInfo.location = CLLocationCoordinate2D()
        NSArray(array: [getReadDataItem(dataInfo: dataInfo)]).write(toFile: dataFilePath, atomically: true)
        print("\(dataFilePath) 不存在，判断为第一次打开程序，文件已创建完毕")
        return true
    }
    
    // 将 DateCountInfo 数据转换成可以记录到本地的字典数据
    static func getReadDataItem(dataInfo: DataInfo) -> [String: String] {
        var recordItem: [String: String] = [:]
        recordItem["index"] = String(dataInfo.firstOpen)
        // 将CLLocationCoordinate2D转换为字符串
           let locationString = "\(dataInfo.location.latitude), \(dataInfo.location.longitude)"
           recordItem["location"] = locationString
        return recordItem
    }
    
    //读取本地数据
    static func readData() -> [DataInfo] {
        let dataFilePath: String = NSHomeDirectory() + "/Documents/location_data.plist"
        let dataInfoArray = NSArray(contentsOfFile: dataFilePath) as? Array<[String: String]> ?? []
        
        var dataInfoList = [DataInfo]()
        
        for dataDictionary in dataInfoArray {
            let data = DataInfo()
            
            if let indexString = dataDictionary["index"], let firstOpen = Int(indexString) {
                data.firstOpen = firstOpen
            }
            
            if let locationString = dataDictionary["location"] {
                // Convert locationString back to CLLocationCoordinate2D
                let locationComponents = locationString.components(separatedBy: ", ")
                if locationComponents.count == 2,
                   let latitude = CLLocationDegrees(locationComponents[0]),
                   let longitude = CLLocationDegrees(locationComponents[1]) {
                    data.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                }
            }
            dataInfoList.append(data)
        }
        
        return dataInfoList
    }
    
    //写入数据
    static func writeDate(dataInfoArr: [DataInfo]) {
        let dataFilePath:String = NSHomeDirectory() + "/Documents/location_data.plist"
        var dateCountInfoDicArr: Array<[String: String]> = []
        for info in dataInfoArr {
            dateCountInfoDicArr.append(getReadDataItem(dataInfo: info))
        }
        NSArray(array: dateCountInfoDicArr).write(toFile: dataFilePath, atomically: true)
        print("写入数据成功")
    }
    
    func readTheJSON() {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("location_data.plist")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                // 文件存在，可以进行读取操作
                if let data = FileManager.default.contents(atPath: fileURL.path) {
                    do {
                        let plist = try PropertyListSerialization.propertyList(from: data, format: nil)
                        if let dataDictionary = plist as? [String: Any] {
                            // 将字典转换为 JSON 格式
                            if let jsonData = try? JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted),
                               let jsonString = String(data: jsonData, encoding: .utf8) {
                                print("jsonString: \(jsonString)")
                            }
                        }
                    } catch {
                        print("Error reading plist: \(error)")
                    }
                } else {
                    print("Error loading file data.")
                }
            } else {
                print("File does not exist.")
            }
        }

    }
}
