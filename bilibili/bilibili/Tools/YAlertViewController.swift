//
//  YAlertViewController.swift
//  YunVideo
//
//  Created by cll12_12 on 16/8/5.
//  Copyright © 2016年 ifdoo. All rights reserved.
//

import UIKit

class YAlertViewController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func showAlertController(view: UIViewController, title: String, message: String) -> YAlertViewController {
        
        let alert = YAlertViewController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
        alert.addAction(okAction)
        view.presentViewController(alert, animated: false, completion: nil)
        return alert
    }
    
}
