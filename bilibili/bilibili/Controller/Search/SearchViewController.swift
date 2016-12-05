//
//  SearchViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchHelper: SearchViewHelper?
    var everyoneSearchDataSource: [KeywordModel]?
    
    var w: CGFloat = 0
    var h: CGFloat = 90
    
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
    
    //MARK: -- private method
    func initBaseLayout() {
        self.navigationController?.navigationBar.hidden = true
        self.view.addSubview(headerView)
        self.headerView.addSubview(searchTextField)
        self.headerView.addSubview(scanCodeBtn)
        self.headerView.addSubview(searchLabel)
    }
    func layoutPageSubViews() {
        headerView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT*0.13)
        }
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
                button.backgroundColor = YYMain_Color
                button.layer.cornerRadius = 8.0
                button.layer.masksToBounds = true
                
                let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(14)]
                let keyword: NSString = NSString(CString: everyoneSearchDataSource![i].keyword!.cStringUsingEncoding(NSUTF8StringEncoding)!, encoding: NSUTF8StringEncoding)!
                let length = keyword.boundingRectWithSize(CGSizeMake(SCREEN_WIDTH, 2000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size.width
                //为button赋值
                let attributeString = NSAttributedString(string: everyoneSearchDataSource![i].keyword!, attributes: attributes)
                button.setAttributedTitle(attributeString, forState: .Normal)
                //设置button的frame
                button.frame = CGRectMake(10 + w, h, length + 15, 30)
                //当button的位置超出右侧边缘时换行
                if 10+w+length+15 > SCREEN_WIDTH {
                    w = 0
                    h = h + button.frame.size.height + 10
                    button.frame = CGRectMake(10+w, h, length+15, 30)
                }
                w = button.frame.size.width + button.frame.origin.x
                self.headerView.addSubview(button)
            }
        }
    }
    
    //MARK: -- setter and getter
    var _headerView: UIView!
    var headerView: UIView {
        if _headerView == nil {
            _headerView = UIView()
            _headerView.backgroundColor = YYMain_Color
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