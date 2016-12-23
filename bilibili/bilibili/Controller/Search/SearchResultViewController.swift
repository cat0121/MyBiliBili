//
//  SearchResultViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/6.
//  Copyright © 2016年 yan. All rights reserved.
//

//搜索结果页: http://app.bilibili.com/x/v2/search?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&duration=0&keyword=夏目友人帐&mobi_app=iphone&order=default&platform=ios&pn=1&ps=20&rid=0&sign=f2be0e64fb813ccad09ec9ac02fdde8d&ts=1480906803

//搜索出的相关名字：http://api.bilibili.com/suggest?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&main_ver=v3&mobi_app=iphone&platform=ios&sign=35a9c5e4a9b3d64387775de3144fdb55&term=夏目&ts=1480905629（模糊查询）
//专题：http://app.bilibili.com/x/v2/search/type?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&keyword=夏目友人帐&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=e773781d4bf8f079b6ab69e4dd05ecf6&ts=1480905680&type=4
//UP主：http://app.bilibili.com/x/v2/search/type?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&keyword=%E5%A4%8F%E7%9B%AE%E5%8F%8B%E4%BA%BA%E5%B8%90&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=39b1613167cf457994e3cc36cdc1ee0e&ts=1480905680&type=2
//番剧：http://app.bilibili.com/x/v2/search/type?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&keyword=%E5%A4%8F%E7%9B%AE%E5%8F%8B%E4%BA%BA%E5%B8%90&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=39b1613167cf457994e3cc36cdc1ee0e&ts=1480905680&type=1
import UIKit
import CSNetManager

class SearchResultViewController: UIViewController {
    
    var searchResultHelper: SearchResultViewHelper?
    var scnav: SCNavTabBarController?

    //模糊查询结果
    var fuzzyDataSource: [EachModel]?
    //存储历史记录的数组
    var historyArr: [String]?
    var userDefaults: NSUserDefaults?
    // 标识符，历史记录中是否含有这个keyword
    var flag: Int = 0
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
    }
    
    //MARK: -- event response
    func cancelSearch(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    func valueChange(textField: UITextField) {
        if textField.text?.characters.count > 0 {
            
            searchResultHelper?.fuzzyModel!.keyword = textField.text
            searchResultHelper?.fuzzyManager?.loadData()
        }
    }
    func buttonClick(sender: UIButton) {
        userDefaults?.removeObjectForKey("searchHistory")
        historyArr?.removeAll()
        historyTableView.reloadData()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        //神奇的导航条 设置为不透明
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.hidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = cancelBtn
        self.navigationItem.titleView = searchTextField
        self.view.addSubview(historyTableView)
        self.view.addSubview(fuzzyTableView)
    }
    func layoutPageSubviews() {
        
        historyTableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
//            make.height.equalTo(SCREEN_HEIGHT)
            make.bottom.equalTo(self.view).offset(0)
        }
        fuzzyTableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT)
        }
    }
    func initHelper() {
        searchResultHelper = SearchResultViewHelper()
        searchResultHelper?.callBackDelegate = self
        searchResultHelper?.resultViewController = self
        
        fuzzyDataSource = [EachModel]()
        userDefaults = NSUserDefaults.standardUserDefaults()
        historyArr = userDefaults!.objectForKey("searchHistory") as? [String]
        historyTableView.hidden = false
        fuzzyTableView.hidden = true
    }
    /**
       本地存储搜索记录
     */
    func localStorageDataWithString(keyword: String) {
        //进入页面后第一次搜索
        if historyArr == nil {
            historyArr = [String]()
            let arr = userDefaults!.objectForKey("searchHistory") as? [String]
            //将本地数据添加到arr中
            if historyArr != nil && historyArr?.count > 0 {
                historyArr = arr
            }
        }
        //判断是否有相同的搜索记录
        for str in historyArr! {
            if str == keyword {
                flag = 1
                break
            }
        }
        if flag != 1 {
            historyArr?.append(keyword)
        }

        userDefaults!.setObject(historyArr, forKey: "searchHistory")
        userDefaults!.synchronize()
    }
    
    /**
     创建五个tabitem
     */
    func setUpTabBar(keyword: String) {
        let searchSynthesis = SearchSynthesisViewController()
        searchSynthesis.title = "综合"
        searchSynthesis.keyword = keyword
        let bangumi = SearchBangumiViewController()
        bangumi.title = "番剧"
        bangumi.keyword = keyword
        let UP = SearchUPViewController()
        UP.title = "UP主"
        UP.keyword = keyword
        let moive = SearchMoiveViewController()
        moive.title = "影视"
        let subject = SearchSubjectViewController()
        subject.title = "专题"
        subject.keyword = keyword
        
        scnav = SCNavTabBarController()
        scnav!.subViewControllers = [searchSynthesis,bangumi,UP,moive,subject]
        scnav!.navTabBarColor = UIColor(red: 0.89, green: 0.49, blue: 0.61, alpha: 1)
        scnav!.addParentController(self)
    }
    
    //MARK: -- setter and getter
    var _searchTextField: UITextField!
    var searchTextField: UITextField {
        if _searchTextField == nil {
            _searchTextField = UITextField(frame: CGRectMake(0, 25, 280, SCREEN_HEIGHT*0.045))
            _searchTextField.placeholder = "搜索视频、番剧、up主或AV号"
            _searchTextField.backgroundColor = UIColor.whiteColor()
            _searchTextField.borderStyle = .RoundedRect
            _searchTextField.layer.cornerRadius = 8.0
            _searchTextField.font = UIFont.systemFontOfSize(14)
            _searchTextField.textColor = UIColor.blackColor()
            _searchTextField.returnKeyType = .Search
            //设置leftView
            let leftView = UIImageView(image: UIImage(named: "home_discovery_tab"))
            leftView.frame = CGRectMake(-20, 0, 20, 20)
            _searchTextField.leftView = leftView
            _searchTextField.leftViewMode = .Always
            //点击事件
            _searchTextField.addTarget(self, action: #selector(SearchResultViewController.valueChange(_:)), forControlEvents: UIControlEvents.AllEditingEvents)
            //设置代理
            _searchTextField.delegate = self
        }
        return _searchTextField
    }
    var _cancelBtn:UIBarButtonItem!
    var cancelBtn:UIBarButtonItem{
        if _cancelBtn == nil{
            _cancelBtn = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(SearchResultViewController.cancelSearch(_:)))
            _cancelBtn.tintColor = UIColor.whiteColor()
            
        }
        return _cancelBtn
    }
    var _leftBackBtn:UIBarButtonItem!
    var leftBackBtn:UIBarButtonItem{
        if _leftBackBtn == nil{
            _leftBackBtn = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            _leftBackBtn.tintColor = UIColor.whiteColor()
            
        }
        return _leftBackBtn
    }
    //模糊查询table
    var _fuzzyTableView: UITableView!
    var fuzzyTableView: UITableView {
        if _fuzzyTableView == nil {
            _fuzzyTableView = UITableView(frame: CGRectZero, style: .Plain)
            _fuzzyTableView.backgroundColor = YYBackgroundColor
            _fuzzyTableView.delegate = self
            _fuzzyTableView.dataSource = self
            
            _fuzzyTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "fuzzyCell")
        }
        return _fuzzyTableView
    }
    var _historyTableView: UITableView!
    var historyTableView: UITableView {
        if _historyTableView == nil {
            _historyTableView = UITableView(frame: CGRectZero, style: .Plain)
            _historyTableView.backgroundColor = YYBackgroundColor
            _historyTableView.delegate = self
            _historyTableView.dataSource = self
            
            _historyTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "historyCell")
        }
        return _historyTableView
    }
}

extension SearchResultViewController: SearchResultViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(FuzzySearchManager) {
            fuzzyDataSource = searchResultHelper?.fuzzyModel?.eachData
            fuzzyTableView.reloadData()
        }
    }
    func callBackFailure() {
        
    }
}
extension SearchResultViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case fuzzyTableView:
            if fuzzyDataSource?.count > 0 {
                return fuzzyDataSource!.count
            }
        case historyTableView:
            if historyArr?.count > 0 {
                return historyArr!.count
            }
        default:
            break
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch tableView {
        case fuzzyTableView:
            let cell = tableView.dequeueReusableCellWithIdentifier("fuzzyCell")
            cell?.textLabel?.text = fuzzyDataSource![indexPath.row].name
            return cell!
        case historyTableView:
            let cell = tableView.dequeueReusableCellWithIdentifier("historyCell")
            cell?.textLabel?.text = historyArr![indexPath.row]
            cell?.imageView?.image = UIImage(named: "search_history_icon_normal")
            return cell!
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44)
        button.setTitle("清除搜索历史", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: #selector(SearchViewController.buttonClick(_:))  , forControlEvents: .TouchUpInside)
        footer.addSubview(button)
        
        return footer
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == historyTableView && historyArr?.count > 0 {
            return 44
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == historyTableView {
            searchTextField.text = historyArr![indexPath.row]
            setUpTabBar(historyArr![indexPath.row])
            historyTableView.hidden = true
        }
    }
}
extension SearchResultViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.setUpTabBar(textField.text!)
        historyTableView.hidden = true
        fuzzyTableView.hidden = true
        //本地存储关键字
        if textField.text!.characters.count > 0 {
            localStorageDataWithString(textField.text!)
        }
        
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        self.scnav?.removeFromParentViewController()
        historyTableView.hidden = true
        fuzzyTableView.hidden = false
    }
}