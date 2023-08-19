//
//  HealthModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/10.
//

import Foundation
import HealthKit
import SwiftUI

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
            HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue,
            HKWorkoutTypeIdentifier
        ]
        
        return typeIdentifiers.compactMap { getSampleType(for: $0) }
        
    }
    
    
    //MARK: -运动记录
    //今日、累计、连续
    @Published var alltime: Int?
    @Published var allDay: Int?
    @Published var consecutiveDay: Int?
    
    @Published var todayTime: Double?
    @Published var todayCalorie: Double?
    
    @Published var walkStep: Int?
    @Published var distance: Double?
    
    //MARK: - 心率
    //心率
    @Published var heartRate: Int?
    //静息心率
    @Published var RestingHeartRate: Int?
    
    //MARK: -睡眠数据
    @Published var sleepTime: Double = 0.0
    
    //MARK: -体温(这个无法获取了)
//    var bodyTimeperature: Double?
    
    
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
    func fetchDistancofWalkAndRuning() {
        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        
        // 创建一个今天的日期范围
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: today, end: Date(), options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: distanceType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
            if let error = error {
                // 处理错误
                return
            }
            
            if let distanceSamples = results as? [HKQuantitySample] {
                var totalDistanceInMeters: Double = 0.0
                
                for sample in distanceSamples {
                    totalDistanceInMeters += sample.quantity.doubleValue(for: HKUnit.meter())
                }
                
                let totalDistanceInKilometers = totalDistanceInMeters / 1000.0
                let formattedDistance = String(format: "%.2f", totalDistanceInKilometers)
                
                DispatchQueue.main.async {
                    self.distance = Double(formattedDistance)
                }
                print("今天的运动距离：\(formattedDistance) 公里")
            }
        }
        
        healthStore.execute(query)
    }

    
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
    
  
//    func fetchWalkoutTimeAndEnage() {
//
//        let workoutType = HKObjectType.workoutType()
//
//        let query = HKSampleQuery(sampleType: workoutType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
//            if let error = error {
//                // 处理错误
//                print("获取错误")
//                return
//            }
//
//            if let workouts = results as? [HKWorkout] {
//                for workout in workouts {
//                    DispatchQueue.main.async {
//                        self.todayTime = workout.duration
//                        self.todayCalorie = workout.totalEnergyBurned?.doubleValue(for: HKUnit.calorie()) ?? 0.0
//
//                    }
//                }
//
//            }
//            print("运动时间：\(self.todayTime) 秒")
//
//            print("运动消耗：\(self.todayCalorie) 卡路里")
//        }
//
//        healthStore.execute(query)
//
//    }
    
    //获取运动时间和消耗能量
    func fetchWalkoutTimeAndEnage() {
            let workoutType = HKObjectType.workoutType()

            let calendar = Calendar.current
            let startDate = calendar.startOfDay(for: Date())
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!

            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

            let query = HKSampleQuery(sampleType: workoutType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
                if let error = error {
                    // 处理错误
                    print("获取错误")
                    return
                }

                if let workouts = results as? [HKWorkout] {
                    for workout in workouts {
                        self.todayTime! += workout.duration
                        if let energyBurned = workout.totalEnergyBurned {
                            self.todayCalorie! += energyBurned.doubleValue(for: HKUnit.kilocalorie())
                        }
                    }
                    print("今日运动时间：\(self.todayTime) 秒")
                    print("今日运动消耗：\(self.todayCalorie) 卡路里")
                }
            }
        
            healthStore.execute(query)
        }
}
