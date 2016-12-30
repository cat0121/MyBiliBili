//
//  PersonalInfoViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/30.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    let TagArr = [["我的直播"],["头像","昵称","UID","性别","出生年月","个性签名"],["空间隐私设置","账号安全中心"]]
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: -- private method
    func initBaseLayout() {
        self.title = "个人资料"
        self.view.addSubview(personTableView)
    }
    func layoutPageSubview() {
        
    }
    
    //MARK: -- setter and getter
    var _personTableView: UITableView!
    var personTableView: UITableView {
        if _personTableView == nil {
            _personTableView = UITableView(frame: CGRectZero, style: .Plain)
            _personTableView.backgroundColor = YYBackgroundColor
            
            _personTableView.delegate = self
            _personTableView.dataSource = self
            
            _personTableView.registerClass(PersonImgCell.self, forCellReuseIdentifier: "image")
            _personTableView.registerClass(PersonViewCell.self, forCellReuseIdentifier: "label")
        }
        return _personTableView
    }
    
}

extension PersonalInfoViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("image") as! PersonImgCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("label") as! PersonViewCell
            return cell
        }
    }
    
    
}