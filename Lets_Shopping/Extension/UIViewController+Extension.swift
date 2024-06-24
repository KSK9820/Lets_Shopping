//
//  UIViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/24/24.
//

import UIKit

extension UIViewController {
    
    func makeAlert(title: String, message: String, option: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let ok = UIAlertAction(
            title: option,
            style: .default) { _ in
                completion()
            }
        let cancel = UIAlertAction(
            title: "취소",
            style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
}


