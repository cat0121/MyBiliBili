//
//  SearchSubjectViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/8.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit

class SearchSubjectViewController: UIViewController {
    
    var searchSubViewHelper: SearchSubjectViewHelper?
    var subjectData: SearchSubModel?
    var keyword: String?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubview()
        initHelper()
        loadData()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(subjectTableView)
    }
    func layoutPageSubview() {
        subjectTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, -55, 0))
        }
    }
    func initHelper() {
        searchSubViewHelper = SearchSubjectViewHelper()
        searchSubViewHelper?.callBackDelegate = self
        searchSubViewHelper?.subjectViewController = self
        
        subjectData = SearchSubModel()
    }
    func loadData() {
        searchSubViewHelper?.searchSubModel?.page = 1
        searchSubViewHelper?.searchSubModel?.keyword = keyword
        searchSubViewHelper?.subjectManager?.loadData()
    }
    
    //MARK: -- setter and getter
    var _subjectTableView: UITableView!
    var subjectTableView: UITableView {
        if _subjectTableView == nil {
            _subjectTableView = UITableView(frame: CGRectZero, style: .Plain)
            _subjectTableView.backgroundColor = UIColor.whiteColor()
            _subjectTableView.separatorStyle = .None
            _subjectTableView.rowHeight = SCREEN_HEIGHT*0.135
            
            _subjectTableView.delegate = self
            _subjectTableView.dataSource = self
            
            _subjectTableView.registerClass(SearchSubjectViewCell.self, forCellReuseIdentifier: "subCell")
        }
        return _subjectTableView
    }
}

extension SearchSubjectViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subjectData?.subjects?.count > 0 {
            return (subjectData?.subjects?.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subCell") as! SearchSubjectViewCell
        cell.subModel = subjectData!.subjects![indexPath.row]
        
        return cell
    }
}

extension SearchSubjectViewController: SearchSubjectViewCallBackDelegate {
    func callBackSuccess() {
        subjectData = searchSubViewHelper?.searchSubModel
        subjectTableView.reloadData()
    }
    func  callBackFailure() {
        
    }
}