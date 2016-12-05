//
//  MarkViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//
//http://api.bilibili.com/x/feed/pull?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=e5feee8f0cfab2090979dab87e17c782&ts=1480569537&type=2


import UIKit
import MJRefresh

class MarkViewController: UIViewController {
    
    var markHelper: MarkViewHelper?
    var markDataSource: MarkModel?
    var page = 1
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        
        markHelper?.markManager?.loadData()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(markTableView)
    }
    func layoutPageSubviews() {
        markTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    func initHelper(){
        markHelper = MarkViewHelper()
        markHelper?.callBackDelegate = self
        markHelper?.markViewController = self
        
        markDataSource = MarkModel()
    }
    
    //MARK: -- private method
    var _markTableView: UITableView!
    var markTableView: UITableView {
        if _markTableView == nil {
            _markTableView = UITableView(frame: CGRectZero, style: .Plain)
            _markTableView.backgroundColor = YYBackgroundColor
            _markTableView.separatorStyle = .None
            _markTableView.rowHeight = SCREEN_HEIGHT*0.124
            //代理
            _markTableView.delegate = self
            _markTableView.dataSource = self
            
            let header = MJRefreshNormalHeader(refreshingBlock: { 
                self.markHelper?.markManager?.loadData()
            })
            _markTableView.mj_header = header
            
            let footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                self.markHelper?.markModel?.page = self.page
                self.markHelper?.markManager?.loadData()
                self.page += 1
            })
            _markTableView.mj_footer = footer
            //注册
            _markTableView.registerClass(MarkViewCell.self, forCellReuseIdentifier: "markCell")
        }
        return _markTableView
    }
}

extension MarkViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if markDataSource?.additions?.count > 0 {
            return (markDataSource?.additions?.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("markCell") as! MarkViewCell
        if markDataSource?.additions?.count > 0 {
            cell.addition = markDataSource!.additions![indexPath.row]
        }
        
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = YYBackgroundColor
        let markImg = UIImageView(frame: CGRectMake(8, 10, SCREEN_HEIGHT*0.03, SCREEN_HEIGHT*0.03))
        markImg.image = UIImage(named: "default_img")
        markImg.tintColor = UIColor.blackColor()
       
        let markLabel = UILabel(frame: CGRectMake(38, 10, 50, SCREEN_HEIGHT*0.038))
        markLabel.text = "治愈向"
        markLabel.backgroundColor = UIColor.whiteColor()
        markLabel.layer.borderWidth = 1
        markLabel.textAlignment = .Center
        markLabel.font = UIFont.systemFontOfSize(10)
        markLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
        markLabel.layer.masksToBounds = true
        markLabel.layer.cornerRadius = 13.0
        
        view.addSubview(markImg)
        view.addSubview(markLabel)
        return view
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SCREEN_HEIGHT*0.07
    }
}

extension MarkViewController: MarkViewCallBackDelegate {
    func callBackSuccess() {
        markDataSource = markHelper?.markModel
        markTableView.reloadData()
        markTableView.mj_header.endRefreshing()
        markTableView.mj_footer.endRefreshing()
    }
    func callBackFailure() {
        
    }
}