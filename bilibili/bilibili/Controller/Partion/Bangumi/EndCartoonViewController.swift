//
//  EndCartoonViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/18.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=32&sign=5b17ae4fb4aa30d1f828b3823ef547cf&ts=1479786515
import CSNetManager

class EndCartoonViewController: PartionBangumiBaseViewController {
    
    var endCartoonViewHelper: EndCartoonViewHelper?

    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initHelper()
        endCartoonViewHelper?.endCartoonManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        endCartoonViewHelper = EndCartoonViewHelper()
        endCartoonViewHelper?.callBackDelegate = self
        endCartoonViewHelper?.endCartoonViewController = self
    }
   
    override func footerAction() {
        self.endCartoonViewHelper?.page = count
        self.endCartoonViewHelper?.endAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.endCartoonViewHelper?.endCartoonManager?.loadData()
    }
}
extension EndCartoonViewController: EndCartoonViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(EndCartoonViewManager) {
            dataSource = endCartoonViewHelper?.endCartoonModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(EndAllManager) {
            for item in (endCartoonViewHelper?.endAllModel)! {
                dataSource?.newCartoon?.append(item)
            }
            allCartoonTable.reloadData()
            allCartoonTable.mj_footer.endRefreshing()
        }

    }
    func callBackFailure() {
        
    }
}