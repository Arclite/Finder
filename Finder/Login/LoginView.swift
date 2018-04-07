// Created by Geoff Pado on 4/7/18.
// Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

class LoginView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false

        let appleIDLabel = LoginTextFieldLabel(LoginView.appleIDLabelText)
        let passwordLabel = LoginTextFieldLabel(LoginView.passwordLabelText)

        let appleIDTextField = LoginTextField()
        appleIDTextField.keyboardType = .emailAddress
        appleIDTextField.autocapitalizationType = .none
        appleIDTextField.autocorrectionType = .no

        let passwordTextField = LoginTextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no

        let stackView = UIStackView(arrangedSubviews: [appleIDLabel, appleIDTextField, passwordLabel, passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        self.appleIDTextField = appleIDTextField
        self.passwordTextField = passwordTextField
    }

    // MARK: Boilerplate

    private weak var appleIDTextField: UITextField!
    private weak var passwordTextField: UITextField!

    private static let appleIDLabelText = NSLocalizedString("LoginView.appleIDLabelText", comment: "Text for the label describing the Apple ID login text field")
    private static let passwordLabelText = NSLocalizedString("LoginView.passwordLabelText", comment: "Text for the label describing the password login text field")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
