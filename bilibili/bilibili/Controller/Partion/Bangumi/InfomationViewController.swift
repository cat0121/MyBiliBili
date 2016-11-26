//
//  InfomationViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/18.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&order=senddate&platform=ios&ps=30&rid=51&sign=2b5339538fdbe3658341942251609c40&ts=1479808885

import CSNetManager

class InfomationViewController: PartionBangumiBaseViewController {
    
    var infoViewHelper: InfomationViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        infoViewHelper?.infoManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        infoViewHelper = InfomationViewHelper()
        infoViewHelper?.callBackDelegate = self
        infoViewHelper?.infoViewController = self
    }
    
    override func footerAction() {
        self.infoViewHelper?.page = count
        self.infoViewHelper?.infoAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.infoViewHelper?.infoManager?.loadData()
    }
}
extension InfomationViewController: InfomationViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(InfomationViewManager) {
            dataSource = infoViewHelper?.infoModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(InfomationAllManager) {
            for item in (infoViewHelper?.infoAllModel)! {
                dataSource?.newCartoon?.append(item)
            }
            allCartoonTable.reloadData()
            allCartoonTable.mj_footer.endRefreshing()
        }
    }
    func callBackFailure() {
        
    }
}