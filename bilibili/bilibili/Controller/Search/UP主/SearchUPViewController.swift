//
//  SearchUPViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/8.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit

class SearchUPViewController: UIViewController {
    
    var searchUPHelper: SearchUPViewHelper?
    var searchUPData: SearchUPModel?
    var keyword: String?
    var page: Int?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        loadData()
        
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(searchUPTableView)
    }
    func layoutPageSubviews() {
        searchUPTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, -55, 0))
        }
    }
    func initHelper() {
        searchUPHelper = SearchUPViewHelper()
        searchUPHelper?.callBackDelegate = self
        searchUPHelper?.UPViewController = self
        
        searchUPData = SearchUPModel()
        page = 1
    }
    func loadData(){
        searchUPHelper?.searchUPModel?.keyword = keyword
        searchUPHelper?.searchUPModel?.page = page
        searchUPHelper?.UPManager?.loadData()
    }
    
    //MARK: -- setterand getter
    var _searchUPTableView: UITableView!
    var searchUPTableView: UITableView {
        if _searchUPTableView == nil {
            _searchUPTableView = UITableView(frame: CGRectZero, style: .Plain)
            _searchUPTableView.rowHeight = SCREEN_HEIGHT * 0.14
            _searchUPTableView.backgroundColor = UIColor.whiteColor()
            
            _searchUPTableView.delegate = self
            _searchUPTableView.dataSource = self
            
            _searchUPTableView.registerClass(SearchUPViewCell.self, forCellReuseIdentifier: "UPCell")
        }
        return _searchUPTableView
    }
}

extension SearchUPViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchUPData?.ups?.count > 0 {
            return (searchUPData?.ups?.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UPCell") as! SearchUPViewCell
        cell.upModel = searchUPData!.ups![indexPath.row]
        return cell
    }
}
extension SearchUPViewController: SearchUPViewCallBackDelegate {
    func callBackSuccess() {
        searchUPData = searchUPHelper?.searchUPModel
        searchUPTableView.reloadData()
    }
    func callBackFailure() {
        
    }
}