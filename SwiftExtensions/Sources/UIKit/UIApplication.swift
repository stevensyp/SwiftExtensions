//
//  UIApplication.swift
//  SwiftExtensions
//
//  Created by Steven Syp on 11/12/2019.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import UIKit

public extension UIApplication {
	
	/// Clears the launchscreen cache.
    func clearLaunchScreenCache() {
        do { try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard") }
		catch { print("Failed to delete launch screen cache: \(error)") }
    }

}
