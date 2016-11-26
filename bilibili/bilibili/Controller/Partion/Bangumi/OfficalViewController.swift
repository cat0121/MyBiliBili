//
//  OfficalViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/18.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&order=senddate&platform=ios&ps=30&rid=152&sign=8588393352d4afdd129b88aa8b621d50&ts=1479809687

import CSNetManager

class OfficalViewController: PartionBangumiBaseViewController {
    
    var officalViewHelper: OfficalViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        officalViewHelper?.officalManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        officalViewHelper = OfficalViewHelper()
        officalViewHelper?.callBackDelegate = self
        officalViewHelper?.officalViewController = self
    }
    
    override func footerAction() {
        self.officalViewHelper?.page = count
        self.officalViewHelper?.officalAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.officalViewHelper?.officalManager?.loadData()
    }
}
extension OfficalViewController: OfficalViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(OfficalViewManager) {
            dataSource = officalViewHelper?.officalModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(OfficalAllManager) {
            for item in (officalViewHelper?.officalAllModel)! {
                dataSource?.newCartoon?.append(item)
            }
            allCartoonTable.reloadData()
            allCartoonTable.mj_footer.endRefreshing()
        }
    }
    func callBackFailure() {
        
    }
}