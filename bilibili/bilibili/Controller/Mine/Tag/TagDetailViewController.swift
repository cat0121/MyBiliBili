//
//  TagDetailViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2017/1/4.
//  Copyright © 2017年 yan. All rights reserved.
//

import UIKit

class TagDetailViewController: UIViewController {
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubView()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(tagTableView)
    }
    func layoutPageSubView() {
        _tagTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    //MARK: -- setter and getter
    var _tagTableView: UITableView!
    var tagTableView: UITableView {
        if _tagTableView == nil {
            _tagTableView = UITableView(frame: CGRectZero, style: .Plain)
            _tagTableView.backgroundColor = YYBackgroundColor
            _tagTableView.delegate = self
            _tagTableView.dataSource = self
            
            _tagTableView.registerClass(SearchSynthesisViewCell.self, forCellReuseIdentifier: "tagDCell")
        }
        return _tagTableView
    }
}

extension TagDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tagDCell") as! SearchSynthesisViewCell
        return cell
    }
}
