//
//  CartoonRecommendModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class CartoonRecommendModel: NSObject {
    var banner: [RecBannerModel]?
    var dynamic: [RecBodyModel]?
    var new: [RecBodyModel]?
    var recommend: [RecBodyModel]?
    
    override init() {
        super.init()
    }
    init(banner: [RecBannerModel], dynamic: [RecBodyModel], new: [RecBodyModel], recommend: [RecBodyModel]) {
        self.banner = banner
        self.dynamic = dynamic
        self.new = new
        self.recommend = recommend
    }
}
