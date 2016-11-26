//
//  OPViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=54&sign=910596a9fabe6d54e98e8a1413496726&ts=1479889873

import CSNetManager

class OPViewController: PartionBangumiBaseViewController {
    
    var opViewHelper: OPViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        opViewHelper?.OPManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        opViewHelper = OPViewHelper()
        opViewHelper?.callBackDelegate = self
        opViewHelper?.opViewController = self
    }
    
    override func footerAction() {
        self.opViewHelper?.page = count
        self.opViewHelper?.opAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.opViewHelper?.OPManager?.loadData()
    }
}
extension OPViewController: OPViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(OPViewManager) {
            dataSource = opViewHelper?.OPModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(OPAllManager) {
            for item in (opViewHelper?.opAllModel)! {
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