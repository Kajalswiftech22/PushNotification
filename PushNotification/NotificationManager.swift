//
//  NotificationManager.swift
//  PushNotification
//
//  Created by intern on 1/18/24.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    
    @Published var hasPermission  = false
    
    init() {
        Task {
            await getAuthStatus()
        }
    }
    
    func request() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound])
            await getAuthStatus()
        } catch {
            print(error)
        }
    }
    
    func getAuthStatus() async{
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized, .ephemeral, .provisional:
            hasPermission = true
            
        default:
            hasPermission = false
        }
    }
}
