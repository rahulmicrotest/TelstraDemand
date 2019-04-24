//
//  UIViewController+Extension.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 23/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showAlertWith(message: AlertMessage, style: UIAlertController.Style = .alert) {
        
        let alertController = UIAlertController(title: message.title, message: message.body, preferredStyle: style)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func shouldHideLoader(isHidden: Bool) {
        if (isHidden) {
            MBProgressHUD.hide(for: self.view, animated: true)
        }else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
}
