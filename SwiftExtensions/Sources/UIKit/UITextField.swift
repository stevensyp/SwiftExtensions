//
//  UITextField.swift
//
//  Created by Steven Syp on 7/5/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import UIKit

/// Extends the `UITextField` class with usefull capabilities.
extension UITextField {

    /// Returns true if string is an email (format: abc@def.xyz).
    var isValidEmail: Bool {
        return text!.range(of: "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }


    /// Queues multiple textfields by configuring return key action.
    /// - Parameters:
    ///   - textFields: Array of ordered textfields
    ///   - lastTarget: Defines action of the last textfield
    static func connectTextFields(
        _ textFields: [UITextField],
        lastTarget: Selector = #selector(UIResponder.resignFirstResponder)) {

        guard let lastTextfield = textFields.last else { return }
        lastTextfield.returnKeyType = .done
        lastTextfield.addTarget(lastTextfield, action: lastTarget, for: .editingDidEndOnExit)

        for i in 0 ..< textFields.count - 1 {
            textFields[i].returnKeyType = .next
            textFields[i].addTarget(
                textFields[i + 1],
                action: #selector(UIResponder.becomeFirstResponder),
                for: .editingDidEndOnExit)
        }
    }


    /// Enables exiting return key on multiple textfields.
    /// - Parameter textFields: Array of textfields
    static func textFieldsSouldReturn(_ textFields: [UITextField]) {
        textFields.forEach {
            $0.returnKeyType = .done
            $0.addTarget(
                $0,
                action: #selector(UIResponder.resignFirstResponder),
                for: .editingDidEndOnExit)
        }
    }


    /// Enables/disables multiple textfields at once.
    /// - Parameters:
    ///     - textFields: Array of textfields
    ///     - state: optional - Desired state (simply toggled if not precised).
    static func toggleTextFields(_ textFields: [UITextField], to state: Bool? = nil) {
        textFields.forEach { $0.isEnabled = state ?? !$0.isEnabled }
    }


    /// Verifies if multiple textfields are all filled with text.
    /// - Parameter textFields: Array of textfields
    @discardableResult
    static func areFilled(_ textFields: [UITextField]) -> Bool {
        var emptyTextField: UITextField? = nil { didSet { UIImpactFeedbackGenerator().impactOccurred() }}

        textFields.forEach {
            $0.text = $0.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if ($0.text?.isEmpty == true || ($0.textContentType == .emailAddress && !$0.isValidEmail)) {
                if (emptyTextField == nil) { emptyTextField = $0 }
            }
        }
        return emptyTextField == nil ? true : false
    }


    /// Verifies if two textfields are identical.
    /// - Parameter first: First textfield
    /// - Parameter second: Second textfield
    @discardableResult
    static func areIdentical(_ first: UITextField, _ second: UITextField) -> Bool {
        if let firstText = first.text,
            let secondText = second.text,
            secondText.elementsEqual(firstText) {
            return true
        } else { return false }
    }


    /// Set padding to textfield's content.
    /// - Parameter amount: Amount of padding
    func setPaddingPoints(_ amount: CGFloat) {
        switch self.textAlignment {
        case .left, .natural, .justified:
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            leftViewMode = .always
            rightViewMode = .never
        case .right:
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            rightViewMode = .always
            leftViewMode = .never
        case .center:
            rightViewMode = .never
            leftViewMode = .never
        @unknown default:
            return
        }
    }
}
