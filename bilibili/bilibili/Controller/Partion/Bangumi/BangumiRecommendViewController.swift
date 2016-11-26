//
//  BangumiRecommendViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&network=wifi&plat=1&platform=ios&rid=13&sign=027345f83b5d1a560f8ff0a119d3ef69&ts=1479895659

import UIKit

class BangumiRecommendViewController: PartionRecommendBaseViewController {
    
    var bangumiRecHelper: BangumiRecViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        bangumiRecHelper?.bangumiRecManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        bangumiRecHelper = BangumiRecViewHelper()
        bangumiRecHelper?.callBackDelegate = self
        bangumiRecHelper?.bangumiRecViewController = self
    }
    
}


extension BangumiRecommendViewController: BangumiRecommendCallBackDelegate {
    func callBackSuccess() {
        partionDataSource = bangumiRecHelper?.bangumiModel
        partionRecTableview.reloadData()
    }
    func callBackFailure() {
    }
}
