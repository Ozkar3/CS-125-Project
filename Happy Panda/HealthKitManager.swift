//
//  HealthKitManager.swift
//
//
//  Created by Oscar Zaragoza
//

import Foundation
import HealthKit

class HealthKitManager {

    func setUpHealthRequest(healthStore: HKHealthStore, readSteps: @escaping () -> Void) {
        if HKHealthStore.isHealthDataAvailable(), let stepCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount), let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            healthStore.requestAuthorization(toShare: [stepCount], read: [stepCount, sleepAnalysis]) { success, error in
                if success {
                    readSteps()
                } else if error != nil {
                    print(error ?? "Error")
                }
            }
        }
    }

 
    func readStepCount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }
    
    func readSleepDuration(forDate: Date, healthStore: HKHealthStore, completion: @escaping (TimeInterval) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: forDate)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, samples, error in
            if let sleepSamples = samples as? [HKCategorySample] {
                let duration = sleepSamples.reduce(TimeInterval(0)) { result, sample in
                    return result + sample.endDate.timeIntervalSince(sample.startDate)
                }
                completion(duration)
            } else {
                completion(0)
            }
        }
        
        healthStore.execute(query)
    }
}
