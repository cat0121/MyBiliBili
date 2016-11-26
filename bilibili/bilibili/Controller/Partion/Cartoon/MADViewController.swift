//
//  MADViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=24&sign=9bb89863a7d9a06dea0202fff8c60596&ts=1479867769

import CSNetManager

class MADViewController: PartionBangumiBaseViewController {
    
    var madViewHelper: MADViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        madViewHelper?.MADManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        madViewHelper = MADViewHelper()
        madViewHelper?.callBackDelegate = self
        madViewHelper?.madViewController = self
    }
    
    override func footerAction() {
        self.madViewHelper?.page = count
        self.madViewHelper?.madAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.madViewHelper?.MADManager?.loadData()
    }
}
extension MADViewController: MADViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(MADViewManager) {
            dataSource = madViewHelper?.MADModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(MADAllManager) {
            for item in (madViewHelper?.MADAllModel)! {
                dataSource?.newCartoon?.append(item)
            }
            allCartoonTable.reloadData()
            allCartoonTable.mj_footer.endRefreshing()
        }
    }
    func callBackFailure() {
        allCartoonTable.mj_footer.endRefreshing()
    }
}