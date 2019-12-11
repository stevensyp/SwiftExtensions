//
//  AHButtons.swift
//
//  Created by Steven Syp on 7/1/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import UIKit

// MARK: Primary Button
/// Primary button design style with full color background and white text.
@IBDesignable final class SEPrimaryButton: SEButton {
    fileprivate override func sharedInit() {
        super.sharedInit()
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemBlue
    }

    /// Modifies the color theme of the button.
    @IBInspectable override var colorSet: UIColor {
        didSet {
            setTitleColor(.white, for: .normal)
            backgroundColor = colorSet
        }
    }
}


// MARK: Secondary Button
/// Secondary button design style with transparent color background and colored text.
@IBDesignable final class SESecondaryButton: SEButton {
    fileprivate override func sharedInit() {
        super.sharedInit()
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.25)
    }

    /// Modifies the color theme of the button.
    @IBInspectable override var colorSet: UIColor {
        didSet {
            setTitleColor(colorSet, for: .normal)
            backgroundColor = colorSet.withAlphaComponent(0.25)
        }
    }
}


// MARK: Tertiary Button
/// Tertiary button design style with transparent color background, colored text and a thin colored border.
@IBDesignable final class SETertiaryButton: SEButton {
    fileprivate override func sharedInit() {
        super.sharedInit()
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.75).cgColor
        layer.borderWidth = 1
    }

    /// Modifies the color theme of the button.
    @IBInspectable override var colorSet: UIColor {
        didSet {
            setTitleColor(colorSet, for: .normal)
            backgroundColor = colorSet.withAlphaComponent(0.1)
            layer.borderColor = colorSet.withAlphaComponent(0.75).cgColor
        }
    }
}

// MARK: Quaternary Button
/// Primary button design style with full color background and white text.
@IBDesignable final class SEQuaternaryButton: SEButton {
    fileprivate override func sharedInit() {
        super.sharedInit()
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = UIColor.System.tertiarySystemFill
    }

    /// Modifies the color theme of the button.
    @IBInspectable override var colorSet: UIColor {
        didSet {
            setTitleColor(colorSet, for: .normal)
            backgroundColor = UIColor.System.tertiarySystemFill
        }
    }
}


// MARK: - UIButton Base Class
/// Basic SEButton blueprint
class SEButton: UIButton {

    // MARK: Object Life Cycle
    /// Code initializer
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    /// Storyboard initializer
    /// - Parameter aDecoder: coder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    /// Enable initial preview in storyboard when instantiated.
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    fileprivate func sharedInit() {
        titleLabel?.textColor = .systemBlue
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        layer.cornerRadius = 12
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    /// Adapts the appearance of the button when `isEnabled` is changed.
    override var isEnabled: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: .curveEaseOut,
                animations: { self.alpha = (self.isEnabled ? 1 : 0.25)})
        }
    }

    /// Modifies the color theme of the button.
    @IBInspectable var colorSet: UIColor = .systemBlue {
        didSet { titleLabel?.textColor = colorSet }
    }

    /// Modifies the corner radius of the button.
    @IBInspectable var cornerRadius: CGFloat = 12 {
        didSet { layer.cornerRadius = cornerRadius }
    }

    /// To detail.
    @IBInspectable var superCornerRadius: CGFloat = 0 {
        didSet {
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: superCornerRadius).cgPath
            self.layer.mask = maskLayer
        }
    }
}
