//
// UIDocumentPickerDelegate.swift
//
// Created by Speedyfriend67 on 25.06.24
//
 
import UIKit
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, UIDocumentPickerDelegate {
    var selectedFileURL: URL?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        selectedFileURL = url
        NotificationCenter.default.post(name: NSNotification.Name("FileSelected"), object: url)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        NotificationCenter.default.post(name: NSNotification.Name("FileSelectionCancelled"), object: nil)
    }
}