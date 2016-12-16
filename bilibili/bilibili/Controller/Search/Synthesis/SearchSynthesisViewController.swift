//
//  SearchSynthesisViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/8.
//  Copyright © 2016年 yan. All rights reserved.
//

//搜索结果页: http://app.bilibili.com/x/v2/search?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&duration=0&keyword=夏目友人帐&mobi_app=iphone&order=default&platform=ios&pn=2&ps=20&rid=0&sign=f2be0e64fb813ccad09ec9ac02fdde8d&ts=1480906803

import Foundation
import UIKit
import MJRefresh

class SearchSynthesisViewController: UIViewController {
    
    var synthesisHelper: SearchSynthesisViewHelper?
    var keyword: String?
    var synthesisData: SearchSynthesisModel?
    var page: Int = 1
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        loadData()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(synthesisTableView)
    }
    func layoutPageSubviews() {
        synthesisTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(-34, 0, 0, 0))
        }
    }
    func initHelper() {
        synthesisHelper = SearchSynthesisViewHelper()
        synthesisHelper?.callBackDelegate = self
        synthesisHelper?.synthesisViewController = self
        
        synthesisData = SearchSynthesisModel()
    }
    func loadData() {
        synthesisHelper?.synthesisModel?.page = page
        synthesisHelper?.synthesisModel?.keyword = keyword
        synthesisHelper?.synthesisManager?.loadData()
    }
    
    //MARK: -- setter and getter
    var _synthesisTableView: UITableView!
    var synthesisTableView: UITableView {
        if _synthesisTableView == nil {
            _synthesisTableView = UITableView(frame: CGRectZero, style: .Grouped)
            _synthesisTableView.backgroundColor = UIColor.whiteColor()
            _synthesisTableView.rowHeight = SCREEN_HEIGHT*0.14
            _synthesisTableView.separatorStyle = .None
            
            //添加footer
            let footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                self.page += 1
                self.loadData()
            })
            _synthesisTableView.mj_footer = footer
            
            _synthesisTableView.delegate = self
            _synthesisTableView.dataSource = self
            
            _synthesisTableView.registerClass(SearchSynthesisViewCell.self, forCellReuseIdentifier: "searchSynthesisCell")
        }
        return _synthesisTableView
    }
    
}

extension SearchSynthesisViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if synthesisData?.archives?.count > 0 {
            return (synthesisData?.archives?.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchSynthesisCell") as! SearchSynthesisViewCell
        cell.backgroundColor = YYBackgroundColor
        cell.archives = (synthesisData?.archives?[indexPath.row])!
        
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SearchSynthesisViewHeader()
        header.backgroundColor = YYBackgroundColor
        if synthesisData?.seasons!.count > 0 && synthesisData?.seasons != nil {
            header.seasonModel = (synthesisData?.seasons![section])!
        }
        return header
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if synthesisData?.seasons?.count > 0 {
            return SCREEN_HEIGHT*0.22
        }
        return 0
    }
}
extension SearchSynthesisViewController: SearchSynthesisViewCallBackDelegate {
    func callBackSuccess() {
        if self.page == 1 {
            synthesisData = synthesisHelper?.synthesisModel
        } else {
            for item in (synthesisHelper?.synthesisModel?.archives)! {
                synthesisData?.archives?.append(item)
            }
        }
        synthesisTableView.mj_footer.endRefreshing()
        synthesisTableView.reloadData()
    }
    func callBackFailure() {
        
    }
}