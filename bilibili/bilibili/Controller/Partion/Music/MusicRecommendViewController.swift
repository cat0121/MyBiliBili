//
//  MusicRecommendViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&network=wifi&plat=1&platform=ios&rid=3&sign=6e78068d37d19649040b9fdbc9a7f989&ts=1479889873

import UIKit

class MusicRecommendViewController: PartionRecommendBaseViewController {
    
    var musicRecHelper: MusicRecViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        musicRecHelper?.musicRecManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        musicRecHelper = MusicRecViewHelper()
        musicRecHelper?.callBackDelegate = self
        musicRecHelper?.musicRecViewController = self
    }
    
}


extension MusicRecommendViewController: MusicRecommendCallBackDelegate {
    func callBackSuccess() {
        partionDataSource = musicRecHelper?.musicRecModel
        partionRecTableview.reloadData()
    }
    func callBackFailure() {
    }
}
