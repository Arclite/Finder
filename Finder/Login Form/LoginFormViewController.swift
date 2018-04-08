//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

class LoginFormViewController: UIViewController {
    var submitAction: ((String, String) -> Void)? {
        get { return loginView.submitAction }
        set(newAction) { loginView.submitAction = newAction }
    }

    override func loadView() {
        super.loadView()
        view = LoginFormView()
    }

    // MARK: Boilerplate

    private weak var loginView: LoginFormView! { return view as? LoginFormView }
}
