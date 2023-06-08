//
//  HealthKitManager.swift
//
//
//
//

import Foundation
import HealthKit

class HealthKitManager {

    func setUpHealthRequest(healthStore: HKHealthStore, readSteps: @escaping () -> Void) {
        if HKHealthStore.isHealthDataAvailable(),
            let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
            let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
            let dateOfBirthCharacteristic = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let heightType = HKObjectType.quantityType(forIdentifier: .height),
            let weightType = HKObjectType.quantityType(forIdentifier: .bodyMass) {
            
            healthStore.requestAuthorization(toShare: [stepCount], read: [stepCount, sleepAnalysis, dateOfBirthCharacteristic, heightType, weightType]) { success, error in
                if success {
                    readSteps()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
//    func readSex(healthStore: HKHealthStore, completion: @escaping (HKBiologicalSex?) -> Void) {
//        guard let sexType = HKObjectType.characteristicType(forIdentifier: .biologicalSex) else { return }
//
//        healthStore.requestAuthorization(toShare: nil, read: [sexType]) { success, error in
//            if success {
//                let query = HKCharacteristicType.createQuery(for: sexType, predicate: nil, resultsHandler: { query, result, error in
//                    if let biologicalSex = result as? HKBiologicalSexObject {
//                        completion(biologicalSex.biologicalSex)
//                    } else {
//                        completion(nil)
//                    }
//                })
//
//                healthStore.execute(query)
//            } else {
//                completion(nil)
//            }
//        }
//    }

    func readAge(healthStore: HKHealthStore, completion: @escaping (Int?) -> Void) {
            guard let birthdayType = HKObjectType.characteristicType(forIdentifier: .dateOfBirth) else {
                completion(nil)
                return
            }
            
            healthStore.requestAuthorization(toShare: nil, read: [birthdayType]) { success, error in
                if success {
                    do {
                        let birthdayComponents = try healthStore.dateOfBirthComponents()
                        if let birthday = birthdayComponents.date, let age = Calendar.current.dateComponents([.year], from: birthday, to: Date()).year {
                            completion(age)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        print("Error reading age: \(error.localizedDescription)")
                        completion(nil)
                    }
                } else {
                    print("Error requesting authorization for reading age: \(error?.localizedDescription ?? "")")
                    completion(nil)
                }
            }
        }


    func readBiologicalSex(healthStore: HKHealthStore, completion: @escaping (HKBiologicalSex?) -> Void) {
        guard let biologicalSexType = HKObjectType.characteristicType(forIdentifier: .biologicalSex) else {
            completion(nil)
            return
        }
        
        healthStore.requestAuthorization(toShare: nil, read: [biologicalSexType]) { success, error in
            if success {
                do {
                    let biologicalSex = try healthStore.biologicalSex()
                    completion(biologicalSex.biologicalSex)
                } catch {
                    print("Error reading biological sex: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("Error requesting authorization for reading biological sex: \(error?.localizedDescription ?? "")")
                completion(nil)
            }
        }
    }
    
    func readHeight(healthStore: HKHealthStore, completion: @escaping (Double?) -> Void) {
        guard let heightType = HKObjectType.quantityType(forIdentifier: .height) else {
            completion(nil)
            return
        }
        
        let query = HKSampleQuery(sampleType: heightType, predicate: nil, limit: 1, sortDescriptors: nil) { query, samples, error in
            if let heightSample = samples?.first as? HKQuantitySample {
                let heightInMeters = heightSample.quantity.doubleValue(for: HKUnit.meter())
                let heightInInches = heightInMeters * 39.37
                completion(heightInInches)
            } else {
                completion(nil)
            }
        }
        
        healthStore.execute(query)
    }
    
    func readWeight(healthStore: HKHealthStore, completion: @escaping (Double?) -> Void) {
        guard let weightType = HKObjectType.quantityType(forIdentifier: .bodyMass) else {
            completion(nil)
            return
        }
        
        let query = HKSampleQuery(sampleType: weightType, predicate: nil, limit: 1, sortDescriptors: nil) { query, samples, error in
            if let weightSample = samples?.first as? HKQuantitySample {
                let weightInKilograms = weightSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                completion(weightInKilograms)
            } else {
                completion(nil)
            }
        }
        
        healthStore.execute(query)
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
