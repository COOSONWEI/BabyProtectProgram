//
//  HealthModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/10.
//

import Foundation
import HealthKit

//健康信息的数据模型
//这里涉及到运动记录、运动步数、运动消耗掉的卡路里、体温情况、心率、睡眠情况
class HealthModel: NSObject, ObservableObject {
    
    //Health的所有数据
    let healthStore = HKHealthStore()
    
    private var allHealthDataTypes: [HKSampleType] {
        let typeIdentifiers: [String] = [
            HKQuantityTypeIdentifier.stepCount.rawValue,
            HKQuantityTypeIdentifier.heartRate.rawValue,
            HKQuantityTypeIdentifier.restingHeartRate.rawValue,
            HKCategoryTypeIdentifier.sleepAnalysis.rawValue,
            HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue
        ]
        return typeIdentifiers.compactMap { getSampleType(for: $0) }
    }
    
    //MARK: -运动记录
    //今日、累计、连续
    var alltime: Int?
    var allDay: Int?
    var consecutiveDay: Int?
    
    var todayTime: Int?
    var todayCalorie: Int?
    
    var walkStep: Int?
    var runStep: String?
    
    //MARK: - 心率
    //心率
    var heartRate: Int?
    //静息心率
    var RestingHeartRate: Int?
    
    //MARK: -睡眠数据
    var sleepTime: TimeInterval = 0.0
    
    //MARK: -体温
    var bodyTimeperature: Double?
    
    
    //MARK: -获取相关的健康数据
    //请健康数据获取
    func requestHealthKitPermissions() {
        
        var readDataTypes = Set(self.allHealthDataTypes)
        var shareDataTypes = Set(self.allHealthDataTypes)
       
           healthStore.requestAuthorization(toShare: shareDataTypes, read: readDataTypes) { success, error in
               if success {
                   print("HealthKit authorization granted")
               } else {
                   print("HealthKit authorization denied")
               }
           }
       }
    
    ////获取步数
    func fetchTodayStepCount() {
        
           let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
           
           let calendar = Calendar.current
           let todayStartDate = calendar.startOfDay(for: Date())
           let todayEndDate = calendar.date(byAdding: .day, value: 1, to: todayStartDate)!
           
           let datePredicate = HKQuery.predicateForSamples(withStart: todayStartDate, end: todayEndDate, options: .strictStartDate)
           
           let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: datePredicate, options: .cumulativeSum) { query, result, error in
               if let result = result, let sum = result.sumQuantity() {
                   DispatchQueue.main.async {
                       self.walkStep = Int(sum.doubleValue(for: HKUnit.count()))
                       print("self.walkStep \( self.walkStep))")
                   }
               }
           }
           healthStore.execute(query)
        
       }
    
    //获取运动的距离
    
    
    //获取心率
    func fetchCurrentHeartRate() {
        
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        let calendar = Calendar.current
        let halfHourAgo = calendar.date(byAdding: .minute, value: -30, to: Date())!
        
        let datePredicate = HKQuery.predicateForSamples(withStart: halfHourAgo, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: datePredicate, options: .discreteAverage) { query, result, error in
            if let result = result, let average = result.averageQuantity() {
                DispatchQueue.main.async {
                    self.heartRate = Int(average.doubleValue(for: HKUnit(from: "count/min")))
                    print("self.heartRate\(self.heartRate)")
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    //获取静息心率
    func fetchStaticHeartRate() {
          
           let heartRateType = HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!
           
           let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: nil, options: .discreteAverage) { query, result, error in
               if let result = result, let average = result.averageQuantity() {
                   DispatchQueue.main.async {
                       self.RestingHeartRate = Int(average.doubleValue(for: HKUnit(from: "count/min")))
                        print("self.RestingHeartRate\(self.RestingHeartRate)")
                   }
               }
           }
           
           healthStore.execute(query)
       }
    
    //获取睡眠时间
    func fetchSleepData() {
        
            let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
            
            let datePredicate = HKQuery.predicateForSamples(withStart: Date().addingTimeInterval(-86400), end: Date(), options: .strictStartDate)
            
            let query = HKSampleQuery(sampleType: sleepType, predicate: datePredicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
                if let samples = samples {
                    var totalSleepDuration: TimeInterval = 0.0
                    for sample in samples {
                        if let sample = sample as? HKCategorySample,
                           sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                            totalSleepDuration += sample.endDate.timeIntervalSince(sample.startDate)
                        }
                    }
                    DispatchQueue.main.async {
                        self.sleepTime = totalSleepDuration
                        print("self.sleepTime\(self.sleepTime)")
                    }
                }
            }
            
            healthStore.execute(query)
        }
}
