//
//  UIAnimation.swift
//  autohealth
//
//  Created by Steven Syp on 7/17/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import UIKit

/// Animation manager with usefull helpers.
class SEAnimation {

    /// Stored generic animation duration value.
    static let duration: Double = 0.1
    /// Stored generic animation long duration value.
    static let longDuration: Double = 0.25

    /// Animate the given view's border to a new color or/and width.
    /// - Parameters:
    ///   - view: View to animate
    ///   - toColor: New border color (optional)
    ///   - toWidth: New border width (optional)
    static func animateBorder(in view: UIView, toColor: UIColor? = nil, toWidth: CGFloat? = nil) {
        if let toColor = toColor {
            let animation: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
            animation.fromValue = view.layer.borderColor
            animation.toValue = toColor.cgColor
            animation.duration = duration
            view.layer.add(animation, forKey: "borderColor")
            view.layer.borderColor = toColor.cgColor
        }

        if let toWidth = toWidth {
            let animation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
            animation.fromValue = view.layer.borderWidth
            animation.toValue = toWidth
            animation.duration = duration
            view.layer.add(animation, forKey: "borderWidth")
            view.layer.borderWidth = toWidth
        }
    }
}
