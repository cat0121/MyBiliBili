//
//  ShortFilmViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=47&sign=ef47fcebf5ffafb19ce13674200895cb&ts=1479868992

import CSNetManager

class ShortFilmViewController: PartionBangumiBaseViewController {
    
    var shortViewHelper: ShortFilmViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        shortViewHelper?.shortManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        shortViewHelper = ShortFilmViewHelper()
        shortViewHelper?.callBackDelegate = self
        shortViewHelper?.shortViewController = self
    }
    
    override func footerAction() {
        self.shortViewHelper?.page = count
        self.shortViewHelper?.shortAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.shortViewHelper?.shortManager?.loadData()
    }
}
extension ShortFilmViewController: ShortFilmViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(ShortFilmViewManager) {
            dataSource = shortViewHelper?.shortModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(ShortFilmAllManager) {
            for item in (shortViewHelper?.shortAllModel)! {
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
