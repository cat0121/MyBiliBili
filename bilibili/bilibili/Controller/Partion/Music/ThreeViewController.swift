//
//  ThreeViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=29&sign=965523550b8740f0b255f108a5f30f55&ts=1479889873

import CSNetManager

class ThreeViewController: PartionBangumiBaseViewController {
    
    var threeViewHelper: ThreeViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        threeViewHelper?.threeManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        threeViewHelper = ThreeViewHelper()
        threeViewHelper?.callBackDelegate = self
        threeViewHelper?.threeViewController = self
    }
    
    override func footerAction() {
        self.threeViewHelper?.page = count
        self.threeViewHelper?.threeAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.threeViewHelper?.threeManager?.loadData()
    }
}
extension ThreeViewController: ThreeViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(ThreeViewManager) {
            dataSource = threeViewHelper?.threeModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(ThreeAllManager) {
            for item in (threeViewHelper?.threeAllModel)! {
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
