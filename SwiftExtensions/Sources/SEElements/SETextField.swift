//
//  AHTextFields.swift
//  autohealth
//
//  Created by Steven Syp on 7/2/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import UIKit

@IBDesignable final class SETextField: UITextField {

    // MARK: State
    /// Possible states for the textfield.
    enum SETextFieldState { case empty, active, filled, incorrect, disabled, enabled }
    /// The current state of the textfield.
    private(set) var currentState: SETextFieldState = .empty

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

    /// Shared initializer
    public func sharedInit() {
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        delegate = self

        borderStyle = .none
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = 12
        clipsToBounds = true
        backgroundColor = UIColor.System.quaternarySystemFill

        textAlignment = .left
        setPaddingPoints(12)
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "Placeholder",
            attributes: [
                .foregroundColor: UIColor.System.placeholderText,
                .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ])
    }
}

// MARK: UI State Modification
extension SETextField {

    /// Changes the state of the textfield and adapts its appearance (w/o animation).
    /// - Parameters:
    ///   - state: New state
    ///   - animated: Animate the change or not (default value is `true`)
    func setState(_ state: SETextFieldState, animated: Bool = true) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            switch state {
            case .disabled:
                self.alpha = 0.25
            case .enabled:
                self.alpha = 1
            case .empty:
                SEAnimation.animateBorder(in: self, toColor: .clear, toWidth: 0)
                self.backgroundColor = UIColor.System.quaternarySystemFill
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [
                        .foregroundColor: UIColor.System.placeholderText,
                        .font: UIFont.systemFont(ofSize: 16, weight: .medium)])
            case .active:
                SEAnimation.animateBorder(in: self, toColor: UIColor.System.tertiarySystemFill, toWidth: 2)
                self.backgroundColor = UIColor.System.secondarySystemGroupedBackground
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [
                        .foregroundColor: UIColor.System.placeholderText,
                        .font: UIFont.systemFont(ofSize: 16, weight: .medium)])
            case .filled:
                SEAnimation.animateBorder(in: self, toColor: UIColor.System.tertiarySystemFill, toWidth: 1)
                self.backgroundColor = UIColor.System.secondarySystemGroupedBackground
            case .incorrect:
                SEAnimation.animateBorder(in: self, toColor: UIColor.red.withAlphaComponent(0.75), toWidth: 2)
                self.backgroundColor = UIColor.red.withAlphaComponent(0.05)
                self.attributedPlaceholder = NSAttributedString( string: self.placeholder!, attributes: [
                        .foregroundColor: UIColor.red.withAlphaComponent(0.65),
                        .font: UIFont.systemFont(ofSize: 16, weight: .medium)])
            }
        }, completion: nil)
    }
}


// MARK: Delegates
extension SETextField: UITextFieldDelegate {
    /// Sets the active state to the textfield.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setState(.active)
    }

    /// Sets the corresponding inactive state to the textfield depending on its content.
    func textFieldDidEndEditing(_ textField: UITextField) {
        text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if (text!.isEmpty && currentState != .incorrect) { setState(.empty) }
        else if (textContentType == .emailAddress && !isValidEmail) { setState(.incorrect) }
        else { setState(.filled) }
        layoutIfNeeded()
    }

    /// Sets the active state to the textfield when text is changed.
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (currentState == .incorrect) { setState(.active) }
    }
}
