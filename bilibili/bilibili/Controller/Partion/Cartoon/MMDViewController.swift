//
//  MMDViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//
//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=25&sign=ab67728087927dea174a4eabba351e6c&ts=1479867769
import CSNetManager

class MMDViewController: PartionBangumiBaseViewController {
    
    var mmdViewHelper: MMDViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        mmdViewHelper?.MMDManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        mmdViewHelper = MMDViewHelper()
        mmdViewHelper?.callBackDelegate = self
        mmdViewHelper?.mmdViewController = self
    }
    
    override func footerAction() {
        self.mmdViewHelper?.page = count
        self.mmdViewHelper?.mmdAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.mmdViewHelper?.MMDManager?.loadData()
    }
}
extension MMDViewController: MMDViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(MMDViewManager) {
            dataSource = mmdViewHelper?.MMDModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(MMDAllManager) {
            for item in (mmdViewHelper?.MMDAllModel)! {
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
