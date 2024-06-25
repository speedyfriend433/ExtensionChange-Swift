//
// My App.swift
//
// Created by Speedyfriend67 on 25.06.24
//
 
import SwiftUI

@main
struct YourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("FileSelected"), object: nil, queue: .main) { notification in
                        if let url = notification.object as? URL {
                            appDelegate.selectedFileURL = url
                        }
                    }
                }
        }
    }
}