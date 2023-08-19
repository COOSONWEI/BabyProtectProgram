//
//  DataManager.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import Foundation

//数据管理对象，用于提供读取、写入本地数据的方法
class DataManager {
    //是否是第一次运行
    static func isFirstRuning() -> Bool {
        let dataFilePath: String = NSHomeDirectory() + "/Documents/data_info.plist"
        
        if FileManager.default.fileExists(atPath: dataFilePath) {
            print("\(dataFilePath) 存在，不是第一次打开程序")
            return false
        }
        //如果该文件不存在，那么就在本地的沙盒创建它
        print("\(dataFilePath) 不存在，判断为第一次打开程序，文件已创建完毕")
        let dataInfo = DataInfo()
        dataInfo.firstuse = 0
        dataInfo.phone = ""
        NSArray(array: [getReadDataItem(dataInfo: dataInfo)]).write(toFile: dataFilePath, atomically: true)
        print("\(dataFilePath) 不存在，判断为第一次打开程序，文件已创建完毕")
        return true
    }
    
    // 将 DateCountInfo 数据转换成可以记录到本地的字典数据
    static func getReadDataItem(dataInfo: DataInfo) -> [String: String] {
        var recordItem: [String: String] = [:]
        recordItem["index"] = String(dataInfo.firstuse)
        recordItem["phone"] = dataInfo.phone
        return recordItem
    }
    
    //读取本地数据
    static func readData() -> [DataInfo] {
        let dataFilePath: String = NSHomeDirectory() + "/Documents/data_info.plist"
        let dateCountInfoDicArr = NSArray(contentsOfFile: dataFilePath) as! Array<[String: String]>
        var dataInfo = [DataInfo]()
        for index in 0..<dateCountInfoDicArr.count {
           let data = DataInfo()
            data.firstuse = index
            data.phone  = dateCountInfoDicArr[index]["phone"]!
            dataInfo.append(data)
        }
        return dataInfo
    }
    
    //写入数据
    static func writeDate(dataInfoArr: [DataInfo]) {
        let dataFilePath:String = NSHomeDirectory() + "/Documents/data_info.plist"
        var dateCountInfoDicArr: Array<[String: String]> = []
        for info in dataInfoArr {
            dateCountInfoDicArr.append(getReadDataItem(dataInfo: info))
        }
        NSArray(array: dateCountInfoDicArr).write(toFile: dataFilePath, atomically: true)
        
    }
    
}

