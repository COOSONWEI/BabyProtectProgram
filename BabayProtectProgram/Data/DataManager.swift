//
//  DataManager.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import Foundation

struct DataFilePath {
    
   static let phoneDataFilePath: String = NSHomeDirectory() + "/Documents/data_info.plist"
    
    static let emialDataFilePath: String = NSHomeDirectory() + "/Documents/emial_info.plist"
    
}
//数据管理对象，用于提供读取、写入本地数据的方法
class DataManager {
    //MARK: --手机数据管理
    //是否是第一次运行
    static func isFirstRuning() -> Bool {
        
        
        if FileManager.default.fileExists(atPath: DataFilePath.phoneDataFilePath) {
            print("\(DataFilePath.phoneDataFilePath) 存在，不是第一次打开程序")
            return false
        }
        //如果该文件不存在，那么就在本地的沙盒创建它
        print("\(DataFilePath.phoneDataFilePath) 不存在，判断为第一次打开程序，文件已创建完毕")
        let dataInfo = DataInfo()
        dataInfo.firstuse = 0
        dataInfo.phone = ""
        NSArray(array: [getReadDataItem(dataInfo: dataInfo)]).write(toFile: DataFilePath.phoneDataFilePath, atomically: true)
        print("\(DataFilePath.phoneDataFilePath) 不存在，判断为第一次打开程序，文件已创建完毕")
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
    
    //MARK: --邮箱数据管理
    
   //MARK: 注册处理
    ///是否是第一次打开
    static func initEmailData() -> Bool {
        
        if FileManager.default.fileExists(atPath: DataFilePath.emialDataFilePath) {
            print("\(DataFilePath.emialDataFilePath) 存在，不是第一次打开程序")
            return false
        }
        
        //如果该文件不存在，那么就在本地的沙盒创建它
        print("\(DataFilePath.emialDataFilePath) 不存在，判断为第一次打开程序，文件已创建完毕")
        let dataInfo = EmailInfo()
        dataInfo.firstuse = 0
        dataInfo.email = ""
        dataInfo.passWord = ""
        NSArray(array: [getEmailDataItem(emailInfo: dataInfo)]).write(toFile: DataFilePath.emialDataFilePath, atomically: true)
        print("\(DataFilePath.emialDataFilePath) 不存在，判断为第一次打开程序，文件已创建完毕")
        return true
    }
    
    
    
    //将Email的数据类型转换成键值对
    static func getEmailDataItem(emailInfo: EmailInfo) -> [String : String] {
        var renderDdata: [String:String] = [:]
        renderDdata["index"] = String(emailInfo.firstuse)
        renderDdata["email"] = emailInfo.email
        renderDdata["passWord"] = emailInfo.passWord
        return renderDdata
    }
    
    //读取数据
    static func  readEmailData() -> [EmailInfo] {
        
        var dataInfo = [EmailInfo]()
        //获取本地路径
        if let dataArray = NSArray(contentsOfFile: DataFilePath.emialDataFilePath) as? Array<[String:String]> {
            
            //读取其中的数据，返回一个数据类数组
            for index in 0..<dataArray.count {
                let data = EmailInfo()
                data.firstuse = index
                data.email  = dataArray[index]["email"]!
                data.passWord = dataArray[index]["passWord"]!
                dataInfo.append(data)
            }
        }
        return dataInfo
    }
    
    //加入新的Email数据
    static func writeNewEmailData(emailData: EmailInfo) {
        //在原有的数据字典数组中添加新的数据
        var emailDatas = readEmailData()
        emailDatas.append(emailData)
        //写入数据
        writeEmailData(emaildatas: emailDatas)
        //写入成功标识
        
    }
    
    //写入email数据
    static func writeEmailData(emaildatas: [EmailInfo]) {
        var totalData = [EmailInfo]()
        for info in emaildatas {
            totalData.append(info)
        }
        NSArray(array: totalData).write(toFile: DataFilePath.emialDataFilePath, atomically: true)
    }
    //MARK: 登录处理
    
    //登录检测
    //登录操作检测
    static func loginCheck(emailData: EmailInfo) -> Bool {
        
        if findTheEmail(emialData: emailData.email) && checkThePassword(password: emailData.passWord){
            return true
        }
        return false
        
    }
    //检测输入的邮箱是否存在
    static func findTheEmail(emialData: String?) -> Bool {
        let datas = readEmailData()
        for i in datas {
            if i.email == emialData {
              return true
            }
        }
        return false
    }
    
    //检测密码是否正确
    static func checkThePassword(password: String?) -> Bool {
        let datas = readEmailData()
        for i in datas {
            if i.passWord == password {
              return true
            }
        }
        return false
    }
    
    //修改密码处理
    //先检测输入的邮箱是否存在，如果存在则继续修改密码
    static func remakePassword(emial:String?,password: String) -> Bool {
        
        let emailDatas = readEmailData()
        for data in emailDatas {
            if findTheEmail(emialData: emial) {
              //寻找字典中键对应的值进行修改
                data.passWord = password
            }
        }
        
        return false
        
    }
    
    
}



