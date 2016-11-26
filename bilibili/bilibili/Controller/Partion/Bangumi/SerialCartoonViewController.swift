//
//  SerialCartoonViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/18.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=986a5e5c71e98920fe6bab0e791c2d39&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=33&sign=813c9edf587b3c0ca6fd7055c3938654&ts=1479708475
//http://app.bilibili.com/x/v2/region/show/child/list?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&order=senddate&platform=ios&pn=2&ps=30&rid=33&sign=a0b2695e671119aa71a624932bc45cbf&ts=1479719338
import CSNetManager

class SerialCartoonViewController: PartionBangumiBaseViewController {
    
    var serialCartoonViewHelper: SerialCartoonViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        serialCartoonViewHelper?.serialCartoonManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        
        serialCartoonViewHelper = SerialCartoonViewHelper()
        serialCartoonViewHelper?.callBackDelegate = self
        serialCartoonViewHelper?.serialCartoonViewController = self
    }
    override func footerAction() {
        self.serialCartoonViewHelper?.page = self.count
        self.serialCartoonViewHelper?.serialAllManager?.loadData()
        self.count += 1
    }
    override func headerAction() {
        self.serialCartoonViewHelper?.serialCartoonManager?.loadData()
    }
}

extension SerialCartoonViewController: SerialCartoonViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(SerialCartoonViewManager) {
            dataSource = serialCartoonViewHelper?.serialCartoonModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(SerialAllManager) {
            for i in 0..<(serialCartoonViewHelper?.serialAllModel!.count)! {
                dataSource?.newCartoon?.append((serialCartoonViewHelper?.serialAllModel![i])!)
            }
            allCartoonTable.reloadData()
            allCartoonTable.mj_footer.endRefreshing()
        }
    }
    func callBackFailure() {
        
    }
}