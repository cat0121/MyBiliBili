//
//  SynthesisViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//
//http://app.bilibili.com/x/v2/region/show/child?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=27&sign=95f4f27663f6c819fade587df2a88824&ts=1479867769
import CSNetManager

class SynthesisViewController: PartionBangumiBaseViewController {
    
    var synthesisViewHelper: SynthesisViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        synthesisViewHelper?.synthesisManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        synthesisViewHelper = SynthesisViewHelper()
        synthesisViewHelper?.callBackDelegate = self
        synthesisViewHelper?.synthesisViewController = self
    }
    
    override func footerAction() {
        self.synthesisViewHelper?.page = count
        self.synthesisViewHelper?.synthesisAllManager?.loadData()
        count += 1
    }
    override func headerAction() {
        self.synthesisViewHelper?.synthesisManager?.loadData()
    }
}
extension SynthesisViewController: SynthesisViewCallBackDelegate {
    func callBackSuccess(manager: CSAPIBaseManager) {
        if manager.isKindOfClass(SynthesisViewManager) {
            dataSource = synthesisViewHelper?.synthesisModel
            allCartoonTable.reloadData()
            allCartoonTable.mj_header.endRefreshing()
        }
        if manager.isKindOfClass(SynthesisAllManager) {
            for item in (synthesisViewHelper?.synthesisAllModel)! {
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

