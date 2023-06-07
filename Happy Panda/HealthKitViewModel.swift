//
//  HealthKitViewModel.swift
// 
//
//  Created by Oscar Zaragoza
//

import Foundation
import HealthKit

class HealthKitViewModel: ObservableObject {
    
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userStepCount = ""
    @Published var userSleepDuration: String?
    @Published var isAuthorized = false
    
    init() {
        changeAuthorizationStatus()
    }
    
    //MARK: - HealthKit Authorization Request Method
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
            self.readSleepDuration()
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
    
    
    //MARK: - Read User's Step Count
    func readStepsTakenToday() {
        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
                    self.userStepCount = String(format: "%.0f", step)
                }
            }
        }
    }
    
    //MARK: - Read User's Sleep Duration
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
}
