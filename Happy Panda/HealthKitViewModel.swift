//
//  HealthKitViewModel.swift
// 
//
//

import Foundation
import HealthKit

class HealthKitViewModel: ObservableObject {
    
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userStepCount = ""
    @Published var userSleepDuration: String?
    @Published var isAuthorized = false
    @Published var userAge: Int?
    @Published var userHeight: Double?
    @Published var userWeight: Double?
    @Published var userSex: String?


    
    init() {
        changeAuthorizationStatus()
//        readAge()
//            readHeight()
//            readWeight()
    }
    
    //HealthKit Authorization Request Method
    func healthRequest() {
            healthKitManager.setUpHealthRequest(healthStore: healthStore) {
                self.changeAuthorizationStatus()
                self.readStepsTakenToday()
                self.readSleepDuration()
                self.readAge()
//                self.readHeight()
//                self.readWeight()
                self.readSex()
            }
        }

    
    func changeAuthorizationStatus() {
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = healthStore.authorizationStatus(for: stepQtyType)
        
        switch status {
        case .notDetermined:
            isAuthorized = false
        case .sharingDenied:
            isAuthorized = false
        case .sharingAuthorized:
            DispatchQueue.main.async { [weak self] in
                self?.isAuthorized = true
            }
        @unknown default:
            isAuthorized = false
        }
    }
    func readSex() {
        healthKitManager.readBiologicalSex(healthStore: healthStore) { sex in
            DispatchQueue.main.async {
                let sexString: String
                switch sex {
                case .female:
                    sexString = "Female"
                case .male:
                    sexString = "Male"
                case .other:
                    sexString = "Other"
                case .notSet:
                    sexString = "Not Set"
                case .none:
                    sexString = "Not Set"
                @unknown default:
                    sexString = "Unknown"
                }
                self.userSex = sexString
            }
        }
    }

    
    func readAge() {
        healthKitManager.readAge(healthStore: healthStore) { age in
            DispatchQueue.main.async {
                self.userAge = age
            }
        }
    }

    func readHeight() {
        healthKitManager.readHeight(healthStore: healthStore) { height in
            DispatchQueue.main.async {
                self.userHeight = height
            }
        }
    }

    func readWeight() {
        healthKitManager.readWeight(healthStore: healthStore) { weight in
            DispatchQueue.main.async {
                self.userWeight = weight
            }
        }
    }

    
    //Read User's Step Count
    func readStepsTakenToday() {
        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
                    self.userStepCount = String(format: "%.0f", step)
                }
            }
        }
    }
    
    //Read User's Sleep Duration
    func readSleepDuration() {
        healthKitManager.readSleepDuration(forDate: Date(), healthStore: healthStore) { duration in
            if duration > 0 {
                DispatchQueue.main.async {
                    let hours = Int(duration) / 3600
                    let minutes = (Int(duration) % 3600) / 60
                    self.userSleepDuration = String(format: "%dh %dm", hours, minutes)
                }
            } else {
                DispatchQueue.main.async {
                    self.userSleepDuration = nil
                }
            }
        }
    }
    
    func getUserAge() -> Int? {
        let healthStore = HKHealthStore()
        let healthKitManager = HealthKitManager()
        var userAge: Int?

        healthKitManager.readAge(healthStore: healthStore) { age in
            userAge = age
        }

        return userAge
    }
}
