//
//  TagListViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/29.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class TagListViewController: UIViewController {

    var tagListData: [TagModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBaseLayout()
        layoutPageSubview()
    }

    //MARK: -- event method
    func backClick(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.title = "我关注的标签"
        self.navigationItem.leftBarButtonItem = leftBackBtn
        self.navigationController?.navigationBar.hidden = false
        
        self.view.addSubview(tagTableView)
    }
    func layoutPageSubview() {
        tagTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    //MARK: -- setter and getter
    var _leftBackBtn:UIBarButtonItem!
    var leftBackBtn:UIBarButtonItem{
        if _leftBackBtn == nil{
            _leftBackBtn = UIBarButtonItem(image: UIImage(named: "fullplayer_icon_back"), style: .Plain, target: self, action: #selector(FavouriteListViewController.backClick(_:)))
            _leftBackBtn.tintColor = UIColor.whiteColor()
            
        }
        return _leftBackBtn
    }
    
    var _tagTableView: UITableView!
    var tagTableView: UITableView {
        if _tagTableView == nil {
            _tagTableView = UITableView()
            _tagTableView.backgroundColor = UIColor.whiteColor()
            
            _tagTableView.delegate = self
            _tagTableView.dataSource = self
            
            _tagTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tagListCell")
        }
        return _tagTableView
    }
}

extension TagListViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tagListData?.count > 0 {
            return tagListData!.count
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tagListCell")
        cell?.imageView?.image = UIImage(named: "default_img")
        cell?.textLabel?.text = tagListData![indexPath.row].tag_name
        return cell!
    }
}
