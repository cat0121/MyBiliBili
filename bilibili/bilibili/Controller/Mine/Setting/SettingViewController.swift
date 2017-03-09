//
//  SettingViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2017/1/4.
//  Copyright © 2017年 yan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubView() 
    }
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(settingTableView)
    }
    func layoutPageSubView() {
        settingTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }

    //Mark: -- setter and getter
    var _settingTableView: UITableView!
    var settingTableView: UITableView {
        if _settingTableView == nil {
            _settingTableView = UITableView(frame: CGRectZero, style: .Plain)
            _settingTableView.backgroundColor = YYBackgroundColor
            
            _settingTableView.delegate = self
            _settingTableView.dataSource = self
            
            _settingTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "setCell")
        }
        return _settingTableView
    }
}

extension SettingViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("setCell")
        
        return cell!
    }
}
