//
//  SearchBangumiViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/8.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit

class SearchBangumiViewController: UIViewController {
    
    var bangumiViewHelper: SearchBangumiViewHelper?
    var bangumiData: SearchBanModel?
    var keyword: String?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        loadDate()
        
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(bangumiTableView)
    }
    func layoutPageSubviews() {
        bangumiTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    func initHelper() {
        bangumiViewHelper = SearchBangumiViewHelper()
        bangumiViewHelper?.callBackDelegate = self
        bangumiViewHelper?.bangumiViewController = self
    }
    func loadDate() {
        bangumiViewHelper?.searchBanModel?.page = 1
        bangumiViewHelper?.searchBanModel?.keyword = keyword
        bangumiViewHelper?.bangumiManager?.loadData()
    }
    
    //MARK: -- setter and getter
    var _bangumiTableview: UITableView!
    var bangumiTableView: UITableView {
        if _bangumiTableview == nil {
            _bangumiTableview = UITableView()
            _bangumiTableview.separatorStyle = .None
            _bangumiTableview.rowHeight = SCREEN_HEIGHT*0.22
            _bangumiTableview.backgroundColor = UIColor.whiteColor()
            
            _bangumiTableview.delegate = self
            _bangumiTableview.dataSource = self
            
            _bangumiTableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "bangumiCell")
        }
        return _bangumiTableview
    }

}

extension SearchBangumiViewController: SearchBangumiViewCallBackDelegate {
    func callBackSuccess() {
        bangumiData = bangumiViewHelper?.searchBanModel
        bangumiTableView.reloadData()
        print(bangumiData?.banngumi)
    }
    func callBackFailure() {
        
    }
}

extension SearchBangumiViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bangumiCell")
        
        return cell!
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SearchSynthesisViewHeader()
        header.backgroundColor = YYBackgroundColor
        if bangumiData?.banngumi!.count > 0 && bangumiData?.banngumi != nil {
            header.seasonModel = (bangumiData?.banngumi![section])!
        }
        return header
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if bangumiData?.banngumi?.count > 0 {
            return SCREEN_HEIGHT*0.22
        }
        return 0
    }
}