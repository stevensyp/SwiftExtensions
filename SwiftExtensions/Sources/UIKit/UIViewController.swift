//
//  UIViewController.swift
//
//  Created by Steven Syp on 7/3/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import UIKit

/// Extends the `UIViewController` class with usefull capabilities.
extension UIViewController {

    /// Toggles "tap to dismiss keyboard" on the view controller.
    func hideKeyboardWhenTappedAround(_ toggle: Bool = true) {
        if (toggle == true) {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = true
            view.addGestureRecognizer(tap)
        } else { view.removeGestureRecognizer(view.gestureRecognizers?.first ?? UITapGestureRecognizer()) }
    }

    /// Obj-C exposed function to make it compatible with selectors.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
