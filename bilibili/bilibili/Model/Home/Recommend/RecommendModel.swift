//
//  RecommendModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/10.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class RecommendModel: NSObject {
    var recDetails: [RecDetailsModel]?
    
    override init() {
        super.init()
    }
    init(recDetails: [RecDetailsModel]) {
        self.recDetails = recDetails
    }
}

class RecDetailsModel: NSObject {
    
    var body: [RecBodyModel]?
    var banner: [RecBannerModel]?
    var headerTitle: String!
    
    init(body: [RecBodyModel], banner: [RecBannerModel], headerTitle: String) {
        self.body = body
        self.banner = banner
        self.headerTitle = headerTitle
    }
}

class RecBodyModel: NSObject {
    
    var bodyImage: String?
    //播放次数
    var playcount: Int?
    //弹幕
    var danmaku: Int?
    //名字
    var title: String?
    
    init(bodyImage: String, playcount:Int, danmaku: Int, title: String) {
        self.bodyImage = bodyImage
        self.playcount = playcount
        self.danmaku = danmaku
        self.title = title
    }
}

class RecBannerModel: NSObject {
    
    //图片
    var bannerImage: String?
    //链接
    var uri: String?
    
    init(bannerImage: String, uri: String) {
        self.bannerImage = bannerImage
        self.uri = uri
    }
}