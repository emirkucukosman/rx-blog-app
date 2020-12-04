//
//  UIViewController+.swift
//  RxBlogApp
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import UIKit

extension UIViewController {
    
    func getAlert(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        return alert
    }
    
}
