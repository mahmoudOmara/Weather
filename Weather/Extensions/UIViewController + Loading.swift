//
//  UIViewController + Loading.swift
//  Weather
//
//  Created by mac on 06/04/2022.
//

import Foundation
import SVProgressHUD


extension UIViewController {
    func showLoading() {
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
}
