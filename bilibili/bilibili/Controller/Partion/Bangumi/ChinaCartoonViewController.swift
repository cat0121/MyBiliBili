//
//  ChinaCartoonViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/18.
//  Copyright © 2016年 yan. All rights reserved.
//
//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=153&sign=77c35633e960725524f70d14a1f250ad&ts=1479786515

import CSNetManager

class ChinaCartoonViewController: PartionBangumiBaseViewController {
    
    var chinaCartoonViewHelper: ChinaCartoonViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        chinaCartoonViewHelper?.chinaCartoonManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        chinaCartoonViewHelper = ChinaCartoonViewHelper()
        chinaCartoonViewHelper?.callBackDelegate = self
        chinaCartoonViewHelper?.chinaCartoonViewController = self
    }
    
    override func footerAction() {
        self.chinaCartoonViewHelper?.page = count
        self.chinaCartoonViewHelper?.chinaAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.chinaCartoonViewHelper?.chinaCartoonManager?.loadData()
    }
}
extension ChinaCartoonViewController: ChinaCartoonViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(ChinaCartoonViewManager) {
            dataSource = chinaCartoonViewHelper?.chinaCartoonModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(ChinaAllManager) {
            for item in (chinaCartoonViewHelper?.chinaAllModel)! {
                dataSource?.newCartoon?.append(item)
            }
            allCartoonTable.reloadData()
            allCartoonTable.mj_footer.endRefreshing()
        }
    }
    func callBackFailure() {
        
    }
}