//
//  ChaseViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class ChaseViewController: UIViewController {
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(chaseTableView)
    }
    func layoutPageSubviews() {
        chaseTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: -55, right: 0))
        }
    }
    
    //MARK: -- setter and getter
    var _chaseTableView: UITableView!
    var chaseTableView: UITableView {
        if _chaseTableView == nil {
            _chaseTableView = UITableView(frame: CGRectZero, style: .Plain)
            _chaseTableView.delegate = self
            _chaseTableView.dataSource = self
            
            //注册
            _chaseTableView.registerClass(ChaseViewCell.self, forCellReuseIdentifier: "chaseCell")
        }
        return _chaseTableView
    }
}

extension ChaseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chaseCell")
        
        return cell!
    }
}
