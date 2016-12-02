//
//  PartionBangumiBaseViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/22.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import MJRefresh
import CSNetManager

class PartionBangumiBaseViewController: UIViewController {
    
    var dataSource: SerialCartoonModel?
    var allNewCartoon: [NewCartoonModel]?
    var count = 2
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        dataSource = SerialCartoonModel()
        self.view.addSubview(allCartoonTable)
    }
    func layoutPageSubviews() {
        allCartoonTable.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    func footerAction() {
        
    }
    func headerAction() {
        
    }
    
    //MARK: -- setter and getter
    var _allCartoonTable: UITableView!
    var allCartoonTable: UITableView {
        if _allCartoonTable == nil {
            _allCartoonTable = UITableView()
            _allCartoonTable.backgroundColor = YYBackgroundColor
            _allCartoonTable.rowHeight = SCREEN_HEIGHT*0.14
            _allCartoonTable.delegate = self
            _allCartoonTable.dataSource = self
            
            //添加下拉刷新 （带有最后刷新的时间）
            let header = MJRefreshNormalHeader(refreshingBlock: {
                self.headerAction()
            })
            header.beginRefreshing()
            _allCartoonTable.mj_header = header
            //添加脚视图
            let  footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                self.footerAction()
            })
            _allCartoonTable.mj_footer = footer
            
            //注册
            _allCartoonTable.registerClass(SerialCartoonViewCell.self, forCellReuseIdentifier: "serialCell")
            _allCartoonTable.registerClass(SerialCartoonHeaderView.self, forHeaderFooterViewReuseIdentifier: "serialHeader")
        }
        return _allCartoonTable
    }
}

extension PartionBangumiBaseViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if dataSource?.recCartoon?.count > 0 {
                return (dataSource?.recCartoon?.count)!
            }
        case 1:
            if dataSource?.newCartoon?.count > 0 {
                return (dataSource?.newCartoon?.count)!
            }
        default:
            break
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("serialCell") as! SerialCartoonViewCell
        switch indexPath.section {
        case 0:
            cell.recommendModel = (dataSource?.recCartoon![indexPath.row])!
        case 1:
            cell.newModel = (dataSource?.newCartoon![indexPath.row])!
        default:
            break
        }
        
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("serialHeader") as? SerialCartoonHeaderView
        switch section {
        case 0:
            header!.serImg.image = UIImage(named: "home_recommend")
            header!.serTitle.text = "热门推荐"
        case 1:
            header!.serImg.image = UIImage(named: "home_new_region")
            header!.serTitle.text = "最新视频"
        default:
            break
        }
        
        return header
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SCREEN_HEIGHT*0.05
    }
}