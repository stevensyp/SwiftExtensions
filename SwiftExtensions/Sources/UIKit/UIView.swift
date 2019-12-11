//
//  UIView.swift
//
//  Created by Steven Syp on 7/10/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import UIKit

// MARK: - Designable View
/// UIView subclass which makes common visual properties previewable in storyboards.
/// Instantiate the class through an IBOutlet or subclass it in a storyboard, and adjust/preview the properties in the interface builder.
@IBDesignable class UIViewDesignable: UIView {

    // MARK: Corner Radius
    /// The radius to use when drawing rounded corners for the layer’s background.
    /// Default value is `0.0`.
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    // MARK: Border
    /// The width of the layer’s border.
    /// Default value is `0.0`.
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    /// The color of the layer’s border.
    /// Default value is an opaque black color.
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor { return UIColor(cgColor: color) }
            return nil
        }
        set {
            if let color = newValue { layer.borderColor = color.cgColor }
            else { layer.borderColor = nil }
        }
    }

    // MARK: Shadow
    /// The blur radius (in points) used to render the layer’s shadow.
    /// Default value is `3.0`.
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    /// The opacity of the layer’s shadow.
    /// The value must be between `0.0` and `1.0`. Default value is `0.0`.
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    /// The offset (in points) of the layer’s shadow.
    /// Default value is `(0.0, -3.0)`.
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    /// The color of the layer’s shadow.
    /// Default value is an opaque black color.
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor { return UIColor(cgColor: color) }
            return nil
        }
        set {
            if let color = newValue { layer.shadowColor = color.cgColor }
            else { layer.shadowColor = nil }
        }
    }
}

// MARK: - Gradient View
/// Gradient view previewable in storyboards.
/// Instantiate the class through an IBOutlet or subclass it in a storyboard, and adjust/preview the properties in the interface builder.
@IBDesignable class UIViewGradient: UIView {
    private var gradientLayer: CAGradientLayer!

    // MARK: - Gradient's colors
    /// Color used to start the gradient.
    /// Default value is `.lightGray`.
    @IBInspectable var startColor: UIColor = .lightGray { didSet { setNeedsLayout() } }
    /// Color used to end the gradient.
    /// Default value is `.darkGray`.
    @IBInspectable var endColor: UIColor = .darkGray { didSet { setNeedsLayout() } }

    // MARK: - Gradient's coordinates
    /// Coordinates of the beginning of the gradient.
    /// The values of each cooardinate must be between `0.0` and `1.0`. Default value is `(0.0, 0.0)`.
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0) { didSet { setNeedsLayout() } }
    /// Coordinates of the end of the gradient.
    /// The values of each cooardinate must be between `0.0` and `1.0`. Default value is `(1.0, 1.0)`.
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0) { didSet { setNeedsLayout() } }


    // MARK: Animation function
    /// Animates the gradient view with new colors.
    /// - Parameters:
    ///   - newStartColor: New starting color
    ///   - newEndColor: New ending color
    ///   - duration: Duration of the animation (default value is `0.25`).
    func animate(newStartColor: UIColor, newEndColor: UIColor, duration: Double = 0.25) {
        let fromColors = self.gradientLayer?.colors
        let toColors: [AnyObject] = [newStartColor.cgColor, newEndColor.cgColor]
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")

        self.gradientLayer?.colors = toColors
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.gradientLayer?.add(animation, forKey:"animateGradient")
    }


    // MARK: - Else
    /// Applies the properties values to the gradient layer.
    /// - Warning: You should not call this method directly. If you want to force a layout update, call the `setNeedsLayout()` method instead to do so prior to the next drawing update. If you want to update the layout of your views immediately, call the `layoutIfNeeded()` method.
    override func layoutSubviews() {
        self.gradientLayer = self.layer as? CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPoint.x, y: startPoint.y)
        gradientLayer.endPoint = CGPoint(x: endPoint.x, y: endPoint.y)
    }

    /// Returns the class used to create the layer for instances of this class.
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
