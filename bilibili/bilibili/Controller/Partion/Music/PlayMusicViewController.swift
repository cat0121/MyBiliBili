//
//  PlayMusicViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=59&sign=5e007a3eee645700fca7a7575aae8c5a&ts=1479889873

import CSNetManager

class PlayMusicViewController: PartionBangumiBaseViewController {
    
    var playViewHelper: PlayMusicViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        playViewHelper?.playManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        playViewHelper = PlayMusicViewHelper()
        playViewHelper?.callBackDelegate = self
        playViewHelper?.playViewController = self
    }
    
    override func footerAction() {
        self.playViewHelper?.page = count
        self.playViewHelper?.playAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.playViewHelper?.playManager?.loadData()
    }
}
extension PlayMusicViewController: PlayMusicViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(PlayMusicViewManager) {
            dataSource = playViewHelper?.playModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(PlayMusicAllManager) {
            for item in (playViewHelper?.playAllModel)! {
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
