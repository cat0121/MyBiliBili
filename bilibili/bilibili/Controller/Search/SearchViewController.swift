//
//  SearchViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //大家都在搜的关键字
    var searchHelper: SearchViewHelper?
    var everyoneSearchDataSource: [KeywordModel]?
    //循环创建button用到的宽和高
    var w: CGFloat = 0
    var h: CGFloat = 0
    //列表的数据
    let dataSource: [[String]] = [["兴趣圈","话题中心","活动中心"],["原创排行榜","全区排行榜"],["游戏中心","周边商城"]]
    let imageSource: [[String]] = [["home_region_icon_33","home_region_icon_51","home_region_icon_75"],["home_region_icon_136","home_subregion_recommend"],["mine_gamecenter","search_shopping_normal"]]
    
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubViews()
        initHelper()
        
        searchHelper?.everyoneManager?.loadData()
    }
    
    //MARK: -- event response
    func valueChange(textField: UITextField) {
        
    }
    func scanCode(sender: UIButton) {
        
    }
    func showMore(sender: UIButton) {
        if moreBtn.titleLabel?.text == "查看更多" {
            
            self.headerView.frame.size.height = SCREEN_HEIGHT*0.5
            searchTableView.frame.origin.y = headerView.frame.maxY
            
            searchScrollView.userInteractionEnabled = true
            searchScrollView.frame.size.height = SCREEN_HEIGHT*0.3
            searchScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 500)
            
            moreBtn.frame.origin.y = headerView.frame.maxY - 35
            moreBtn.setTitle("收起", forState: .Normal)
        } else {
            
            self.headerView.frame.size.height = SCREEN_HEIGHT*0.33
            searchTableView.frame.origin.y = headerView.frame.maxY
            
            searchScrollView.userInteractionEnabled = false
            searchScrollView.frame.size.height = SCREEN_HEIGHT*0.145
            
            moreBtn.frame.origin.y = headerView.frame.maxY - 35
            moreBtn.setTitle("查看更多", forState: .Normal)
        }
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.navigationController?.navigationBar.hidden = true
        self.view.addSubview(headerView)
        self.headerView.addSubview(searchTextField)
        self.headerView.addSubview(scanCodeBtn)
        self.headerView.addSubview(searchLabel)
        self.headerView.addSubview(searchScrollView)
        self.headerView.addSubview(moreBtn)
        self.view.addSubview(searchTableView)
    }
    func layoutPageSubViews() {
//        headerView.snp_makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(0)
//            make.left.equalTo(self.view).offset(0)
//            make.width.equalTo(SCREEN_WIDTH)
//            make.height.equalTo(SCREEN_HEIGHT*0.33)
//        }
        searchTextField.snp_makeConstraints { (make) in
            make.left.equalTo(headerView).offset(48)
            make.top.equalTo(headerView).offset(25)
            make.height.equalTo(SCREEN_HEIGHT*0.045)
            make.width.equalTo(SCREEN_WIDTH-55)
        }
        scanCodeBtn.snp_makeConstraints { (make) in
            make.left.equalTo(headerView).offset(10)
            make.top.equalTo(headerView).offset(26)
            make.width.equalTo(32)
            make.height.equalTo(26)
        }
        searchLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headerView).offset(6)
            make.top.equalTo(scanCodeBtn.snp_bottom).offset(13)
            make.height.equalTo(20)
        }
        searchScrollView.snp_makeConstraints { (make) in
            make.top.equalTo(searchLabel.snp_bottom).offset(8)
            make.left.equalTo(headerView).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.bottom.equalTo(headerView).offset(-50)
        }
        moreBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(headerView)
            make.bottom.equalTo(headerView).offset(-15)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        searchTableView.snp_makeConstraints { (make) in
            make.top.equalTo(headerView.snp_bottom).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.height.equalTo(SCREEN_HEIGHT*0.67)
        }
    }
    
    func initHelper() {
        searchHelper = SearchViewHelper()
        searchHelper?.callBackDelegate = self
        searchHelper?.searchViewController = self
        
        everyoneSearchDataSource = [KeywordModel]()
    }
    
    //循环创建button
    func createButton() {
        
        if everyoneSearchDataSource?.count > 0 {
            for i in 0..<everyoneSearchDataSource!.count {
                let button = UIButton(type: .Custom)
                button.backgroundColor = UIColor(red: 224/255.0, green: 141/255.0, blue: 170/255.0, alpha: 1)
                button.layer.cornerRadius = 8.0
                button.layer.masksToBounds = true
                
                let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(14)]
                let keyword: NSString = NSString(CString: everyoneSearchDataSource![i].keyword!.cStringUsingEncoding(NSUTF8StringEncoding)!, encoding: NSUTF8StringEncoding)!
                let length = keyword.boundingRectWithSize(CGSizeMake(SCREEN_WIDTH, 2000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size.width
                //为button赋值
                let attributeString = NSAttributedString(string: everyoneSearchDataSource![i].keyword!, attributes: attributes)
                button.setAttributedTitle(attributeString, forState: .Normal)
                //设置button的frame
                button.frame = CGRectMake(10 + w, h, length + 15, 33)
                //当button的位置超出右侧边缘时换行
                if 10+w+length+15 > SCREEN_WIDTH {
                    w = 0
                    h = h + button.frame.size.height + 10
                    button.frame = CGRectMake(10+w, h, length+15, 33)
                }
                w = button.frame.size.width + button.frame.origin.x
                self.searchScrollView.addSubview(button)
            }
        }
    }
    
    //MARK: -- setter and getter
    var _headerView: UIView!
    var headerView: UIView {
        if _headerView == nil {
            _headerView = UIView()
            _headerView.backgroundColor = YYMain_Color
            _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.33)
        }
        return _headerView
    }
 
    var _searchTextField: UITextField!
    var searchTextField: UITextField {
        if _searchTextField == nil {
            _searchTextField = UITextField()
            _searchTextField.placeholder = "搜索视频、番剧、up主或AV号"
            _searchTextField.backgroundColor = UIColor.whiteColor()
            _searchTextField.borderStyle = .RoundedRect
            _searchTextField.layer.cornerRadius = 8.0
            _searchTextField.font = UIFont.systemFontOfSize(15)
            _searchTextField.textColor = UIColor.blackColor()
            _searchTextField.returnKeyType = .Search
            //设置leftView
            let leftView = UIImageView(image: UIImage(named: "home_discovery_tab"))
            leftView.frame = CGRectMake(-20, 0, 20, 20)
            _searchTextField.leftView = leftView
            _searchTextField.leftViewMode = .Always
            //点击事件
            _searchTextField.addTarget(self, action: #selector(SearchViewController.valueChange(_:)), forControlEvents: UIControlEvents.AllEditingEvents)
            //设置代理
            _searchTextField.delegate = self
        }
        return _searchTextField
    }
    
    var _scanCodeBtn: UIButton!
    var scanCodeBtn: UIButton {
        if _scanCodeBtn == nil {
            _scanCodeBtn = UIButton(type: .Custom)
            _scanCodeBtn.setBackgroundImage(UIImage(named: "scan_btn_normal"), forState: .Normal)
            _scanCodeBtn.addTarget(self, action: #selector(SearchViewController.scanCode(_:)), forControlEvents: .TouchUpInside)
        }
        return _scanCodeBtn
    }
    
    var _searchLabel: UILabel!
    var searchLabel: UILabel {
        if _searchLabel == nil {
            _searchLabel = UILabel()
            _searchLabel.text = "大家都在搜"
            _searchLabel.textColor = UIColor.whiteColor()
            _searchLabel.font = UIFont.systemFontOfSize(14)
        }
        return _searchLabel
    }
    var _searchScrollView: UIScrollView!
    var searchScrollView: UIScrollView {
        if _searchScrollView == nil {
            _searchScrollView = UIScrollView()
            _searchScrollView.userInteractionEnabled = false
            _searchScrollView.backgroundColor = UIColor.clearColor()
            
        }
        return _searchScrollView
    }
    var _moreBtn: UIButton!
    var moreBtn: UIButton {
        if _moreBtn == nil{
            _moreBtn = UIButton(type: .Custom)
            //图片旋转
//            let image = UIImage(CGImage: (UIImage(named: "search_more_btn_normal")!.CGImage)!, scale: 1, orientation: UIImageOrientation.Up)
            _moreBtn.setImage(UIImage(named: "search_more_btn_normal"), forState: .Normal)
            _moreBtn.setTitle("查看更多", forState: .Normal)
            _moreBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            _moreBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
            _moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 5)
            _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(3, -5, 2, 0)
            _moreBtn.addTarget(self, action: #selector(SearchViewController.showMore(_:)), forControlEvents: .TouchUpInside)
            
        }
        return _moreBtn
    }
    var _searchTableView: UITableView!
    var searchTableView: UITableView {
        if _searchTableView == nil {
            _searchTableView = UITableView(frame: CGRectZero, style: .Plain)
            _searchTableView.backgroundColor = UIColor.whiteColor()
            _searchTableView.rowHeight = 50
            _searchTableView.delegate = self
            _searchTableView.dataSource = self
            
            //注册
            _searchTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
            
        }
        return _searchTableView
    }
}

extension SearchViewController: UITextFieldDelegate {
    
}

extension SearchViewController: SearchViewCallBackDelegate {
    func callBackSuccess() {
        everyoneSearchDataSource = searchHelper?.everyModel?.keywords
        createButton()
    }
    func callBackFailure() {
        
    }
}
extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell")
        cell?.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        cell?.imageView?.image = UIImage(named: imageSource[indexPath.section][indexPath.row])
        cell?.accessoryType = .DisclosureIndicator
        return cell!
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = YYBackgroundColor
        return footer
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}