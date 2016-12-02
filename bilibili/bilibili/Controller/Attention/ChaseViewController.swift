//
//  ChaseViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//
//http://bangumi.bilibili.com/api/get_concerned_season?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&page=1&pagesize=30&platform=ios&sign=b4145cc1c239855261fbba049dcd4d94&taid=&ts=1480569537

import UIKit

class ChaseViewController: UIViewController {
    
    var chaseHelper: ChaseViewHelper?
    var chaseDataSource: ChaseModel?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        
        chaseHelper?.chaseManager?.loadData()
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
    func initHelper() {
        chaseHelper = ChaseViewHelper()
        chaseHelper?.callBackDelegate = self
        chaseHelper?.chaseViewController = self
        
        chaseDataSource = ChaseModel()
    }
    
    //MARK: -- setter and getter
    var _chaseTableView: UITableView!
    var chaseTableView: UITableView {
        if _chaseTableView == nil {
            _chaseTableView = UITableView(frame: CGRectZero, style: .Plain)
            _chaseTableView.rowHeight = SCREEN_HEIGHT*0.16
            _chaseTableView.backgroundColor = YYBackgroundColor
            _chaseTableView.separatorStyle = .None
//            _chaseTableView.sele
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
        if chaseDataSource?.chaseDetails?.count > 0 {
            return (chaseDataSource?.chaseDetails?.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chaseCell") as! ChaseViewCell
        if chaseDataSource?.chaseDetails?.count > 0 {
            cell.chaseDetails = chaseDataSource!.chaseDetails![indexPath.row]
        }
        
        return cell
    }
    
}

extension ChaseViewController: ChaseViewCallBackDelegate {
    func callBackSuccess() {
        chaseDataSource = chaseHelper?.chaseModel
        chaseTableView.reloadData()
    }
    func callBackFailure() {
        
    }
}
