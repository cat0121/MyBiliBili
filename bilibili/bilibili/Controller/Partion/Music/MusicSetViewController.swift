//
//  MusicSetViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=130&sign=efe1ce989ad11ccb877ce6a2318d5fc8&ts=1479889873

import CSNetManager

class MusicSetViewController: PartionBangumiBaseViewController {
    
    var musicViewHelper: MusicSetViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        musicViewHelper?.musicViewManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        musicViewHelper = MusicSetViewHelper()
        musicViewHelper?.callBackDelegate = self
        musicViewHelper?.musicViewController = self
    }
    
    override func footerAction() {
        self.musicViewHelper?.page = count
        self.musicViewHelper?.musicAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.musicViewHelper?.musicViewManager?.loadData()
    }
}
extension MusicSetViewController: MusicSetViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(MusicSetViewManager) {
            dataSource = musicViewHelper?.musicModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(MusicSetAllManager) {
            for item in (musicViewHelper?.musicAllModel)! {
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

