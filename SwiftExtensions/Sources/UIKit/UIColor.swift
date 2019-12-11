//
//  UIColors.swift
//
//  Created by Steven Syp on 7/1/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import UIKit

/// Extends the `UIColor` class to enable new types of initializers and add a retro-compatibility to the new dark-mode compatible system colors added in iOS 13.
extension UIColor {

    // MARK: - Initializers
    /// Initialize color from hexadecimal code.
    /// - Parameters:
    ///     - hex: Hexadecimal code (ex: 0xFFFFFF)
    ///     - alpha: Opacity (default value is `1.0`)
    convenience init(hex: Int, alpha: Float = 1.0) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff, alpha: alpha)
    }


    /// Initialize color from red/blue/green model.
    /// Color values must be between 0 and 255.
    /// - Parameters:
    ///     - red: Amount of red
    ///     - green: Amount of green
    ///     - blue: Amount of blue
    ///     - alpha: Opacity (default value is `1.0`)
    convenience init(red r: Int, green g: Int, blue b: Int, alpha a: Float = 1.0) {
        assert(r >= 0 && r <= 255, "Invalid Red Component")
        assert(g >= 0 && g <= 255, "Invalid Green Component")
        assert(b >= 0 && b <= 255, "Invalid Blue Component")
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a))
    }


    /// Create a UIColor with different colors for light and dark mode.
    /// - Parameters:
    ///     - light: Color to use in light/unspecified mode
    ///     - dark: Color to use in dark mode
    @available(iOS 13.0, tvOS 13.0, *)
    convenience init(light: UIColor, dark: UIColor) {
        self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
    }


    // MARK: - Color Additions
    /// System colors retro-compatibility for previous iOS versions.
    enum System {

        // MARK: Labels & Text
        static var label: UIColor {
            if #available(iOS 13, *) { return .label }
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        static var secondaryLabel: UIColor {
            if #available(iOS 13, *) { return .secondaryLabel }
            return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.6)
        }
        static var tertiaryLabel: UIColor {
            if #available(iOS 13, *) { return .tertiaryLabel }
            return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.3)
        }
        static var quaternaryLabel: UIColor {
            if #available(iOS 13, *) { return .quaternaryLabel }
            return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.18)
        }
        static var placeholderText: UIColor {
            if #available(iOS 13, *) { return .placeholderText }
            return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.3)
        }
        static var link: UIColor {
            if #available(iOS 13, *) { return .link }
            return UIColor(red: 0.0, green: 0.47843137254901963, blue: 1.0, alpha: 1.0)
        }
        static var darkText: UIColor {
            if #available(iOS 13, *) { return .darkText }
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        static var lightText: UIColor {
            if #available(iOS 13, *) { return .lightText }
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        }

        // MARK: Fills
        static var systemFill: UIColor {
            if #available(iOS 13, *) { return .systemFill }
            return UIColor(red: 0.47058823529411764, green: 0.47058823529411764, blue: 0.5019607843137255, alpha: 0.2)
        }
        static var secondarySystemFill: UIColor {
            if #available(iOS 13, *) { return .secondarySystemFill }
            return UIColor(red: 0.47058823529411764, green: 0.47058823529411764, blue: 0.5019607843137255, alpha: 0.16)
        }
        static var tertiarySystemFill: UIColor {
            if #available(iOS 13, *) { return .tertiarySystemFill }
            return UIColor(red: 0.4627450980392157, green: 0.4627450980392157, blue: 0.5019607843137255, alpha: 0.12)
        }
        static var quaternarySystemFill: UIColor {
            if #available(iOS 13, *) { return .quaternarySystemFill }
            return UIColor(red: 0.4549019607843137, green: 0.4549019607843137, blue: 0.5019607843137255, alpha: 0.08)
        }

        // MARK: Backgrounds
        static var systemBackground: UIColor {
            if #available(iOS 13, *) { return .systemBackground }
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        static var secondarySystemBackground: UIColor {
            if #available(iOS 13, *) { return .secondarySystemBackground }
            return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
        }
        static var tertiarySystemBackground: UIColor {
            if #available(iOS 13, *) { return .tertiarySystemBackground }
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        static var systemGroupedBackground: UIColor {
            if #available(iOS 13, *) { return .systemGroupedBackground }
            return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
        }
        static var secondarySystemGroupedBackground: UIColor {
            if #available(iOS 13, *) { return .secondarySystemGroupedBackground }
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        static var tertiarySystemGroupedBackground: UIColor {
            if #available(iOS 13, *) { return .tertiarySystemGroupedBackground }
            return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
        }

        // MARK: Separators
        static var separator: UIColor {
            if #available(iOS 13, *) { return .separator }
            return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.29)
        }
        static var opaqueSeparator: UIColor {
            if #available(iOS 13, *) { return .opaqueSeparator }
            return UIColor(red: 0.7764705882352941, green: 0.7764705882352941, blue: 0.7843137254901961, alpha: 1.0)
        }

        // MARK: Grays
        static var systemGray: UIColor {
            if #available(iOS 13, *) { return .systemGray }
            return UIColor(red: 0.5568627450980392, green: 0.5568627450980392, blue: 0.5764705882352941, alpha: 1.0)
        }
        static var systemGray2: UIColor {
            if #available(iOS 13, *) { return .systemGray2 }
            return UIColor(red: 0.6823529411764706, green: 0.6823529411764706, blue: 0.6980392156862745, alpha: 1.0)
        }
        static var systemGray3: UIColor {
            if #available(iOS 13, *) { return .systemGray3 }
            return UIColor(red: 0.7803921568627451, green: 0.7803921568627451, blue: 0.8, alpha: 1.0)
        }
        static var systemGray4: UIColor {
            if #available(iOS 13, *) { return .systemGray4 }
            return UIColor(red: 0.8196078431372549, green: 0.8196078431372549, blue: 0.8392156862745098, alpha: 1.0)
        }
        static var systemGray5: UIColor {
            if #available(iOS 13, *) { return .systemGray5 }
            return UIColor(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.9176470588235294, alpha: 1.0)
        }
        static var systemGray6: UIColor {
            if #available(iOS 13, *) { return .systemGray6 }
            return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
        }
    }
}


