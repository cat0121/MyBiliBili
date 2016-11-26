//
//  MusicRepriseViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=31&sign=7f268ed6628ebfab1d6cd8bf29bef929&ts=1479889873

import CSNetManager

class MusicRepriseViewController: PartionBangumiBaseViewController {
    
    var musicRepriseViewHelper: MusicRepriseViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        musicRepriseViewHelper?.musicRepriseManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        musicRepriseViewHelper = MusicRepriseViewHelper()
        musicRepriseViewHelper?.callBackDelegate = self
        musicRepriseViewHelper?.musicRepriseViewController = self
    }
    
    override func footerAction() {
        self.musicRepriseViewHelper?.page = count
        self.musicRepriseViewHelper?.musicRepriseAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.musicRepriseViewHelper?.musicRepriseManager?.loadData()
    }
}
extension MusicRepriseViewController: MusicRepriseViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(MusicRepriseViewManager) {
            dataSource = musicRepriseViewHelper?.musicRepriseModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(MusicRepriseAllManager) {
            for item in (musicRepriseViewHelper?.musicRepriseAllModel)! {
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
