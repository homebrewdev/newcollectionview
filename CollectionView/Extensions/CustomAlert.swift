//
//  CustomAlert.swift
//  CollectionView
//
//  Created by Egor Devyatov on 19/08/2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit

// вызов алерта в каком нибудьViewController можно сделать вот так:
// UIAlertController.alert(title:"Title", msg:"Message", target: self)
extension UIAlertController {
     class func showAlert(title:String, msg:String, target: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            (result: UIAlertAction) -> Void in
        })
        target.present(alert, animated: true, completion: nil)
    }
}
