//
//  CartoonRecommendViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region/show?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&network=wifi&plat=1&platform=ios&rid=1&sign=f79c38f734d84595dc17d06f18f46259&ts=1479867769
import UIKit

class CartoonRecommendViewController: PartionRecommendBaseViewController {
    
    var cartoonRecHelper: CartoonRecommendViewHelper?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHelper()
        cartoonRecHelper?.cartoonRecManager?.loadData()
    }
    
    //MARK: -- private method
    func initHelper() {
        cartoonRecHelper = CartoonRecommendViewHelper()
        cartoonRecHelper?.callBackDelegate = self
        cartoonRecHelper?.cartoonRecViewController = self
    }
    
}


extension CartoonRecommendViewController: CartoonRecommendCallBackDelegate {
    func callBackSuccess() {
        partionDataSource = cartoonRecHelper?.cartoonModel
        partionRecTableview.reloadData()
    }
    func callBackFailure() {
    }
}