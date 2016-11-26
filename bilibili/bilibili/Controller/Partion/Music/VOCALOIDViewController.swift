//
//  VOCALOIDViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=30&sign=c9114652c8b425be8b505c3f295954eb&ts=1479889873

import CSNetManager

class VOCALOIDViewController: PartionBangumiBaseViewController {
    
    var vocaloidViewHelper: VOCALOIDViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        vocaloidViewHelper?.VOCALOIDManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        vocaloidViewHelper = VOCALOIDViewHelper()
        vocaloidViewHelper?.callBackDelegate = self
        vocaloidViewHelper?.VOCALOIDViewController1 = self
    }
    
    override func footerAction() {
        self.vocaloidViewHelper?.page = count
        self.vocaloidViewHelper?.vOCALOIDAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.vocaloidViewHelper?.VOCALOIDManager?.loadData()
    }
}
extension VOCALOIDViewController: VOCALOIDViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(VOCALOIDViewManager) {
            dataSource = vocaloidViewHelper?.VOCALOIDModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(VOCALOIDAllManager) {
            for item in (vocaloidViewHelper?.VOCALOIDAllModel)! {
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
