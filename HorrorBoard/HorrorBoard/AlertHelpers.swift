//
//  AlertHelpers.swift
//  HorrorBoard
//
//  Created by Hunter Oppel on 10/26/20.
//

import UIKit

extension UIViewController {
    func presentSimpleAlert(with title: String?,
                            message: String?,
                            preferredStyle: UIAlertController.Style = .alert,
                            dismissText: String = "OK",
                            completionUponDismissal: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        let dismissAction = UIAlertAction(title: dismissText, style: .cancel, handler: completionUponDismissal)
        alert.addAction(dismissAction)

        present(alert, animated: true, completion: nil)
    }
}
