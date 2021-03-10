//
//  AppDelegate.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 29.01.2021.
//

import UIKit
import TouchVisualizer

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Visualizer.start()
        return true
    }
}

