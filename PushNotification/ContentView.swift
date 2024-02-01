//
//  ContentView.swift
//  PushNotification
//
//  Created by intern on 1/16/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var store: NotificationManager
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some View {
        Button("Request Notification") {
            Task {
                await store.request()
            }
        }
        .buttonStyle(.bordered)
        .disabled(store.hasPermission)
        .task {
            await store.getAuthStatus()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: NotificationManager())
    }
}
