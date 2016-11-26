//
//  OriginalViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=28&sign=16fbea417f8afef07e49e84f18860458&ts=1479889873

import CSNetManager

class OriginalViewController: PartionBangumiBaseViewController {
    
    var originalViewHelper: OriginalViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        originalViewHelper?.originalManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        originalViewHelper = OriginalViewHelper()
        originalViewHelper?.callBackDelegate = self
        originalViewHelper?.originalViewController = self
    }
    
    override func footerAction() {
        self.originalViewHelper?.page = count
        self.originalViewHelper?.originalAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.originalViewHelper?.originalManager?.loadData()
    }
}
extension OriginalViewController: OriginalViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(OriginalViewManager) {
            dataSource = originalViewHelper?.originalModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(OriginalAllManager) {
            for item in (originalViewHelper?.originalAllModel)! {
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