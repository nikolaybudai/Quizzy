//
//  UIViewController+Extension.swift
//  Quizzy
//
//  Created by Nikolay Budai on 17/11/23.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, coordinator: CoordinatorProtocol?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            coordinator?.goBack()
        }
        alert.addAction(action)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.present(alert, animated: true)
        }
    }
}
