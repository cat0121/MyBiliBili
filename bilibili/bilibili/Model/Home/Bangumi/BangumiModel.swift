//
//  BangumiModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class BangumiModel: NSObject {
    var admodel: adModel?
    var bangumiFirstModel: [BangumiFirstModel]?
    var bangumiSecondModel: BangumiSecondModel?
    override init() {
        super.init()
    }
    init(admodel: adModel, bangumiSecondModel: BangumiSecondModel,bangumiFirstModel: [BangumiFirstModel]) {
        self.admodel = admodel
        self.bangumiFirstModel = bangumiFirstModel
        self.bangumiSecondModel = bangumiSecondModel
    }
}
//dic["ad"]
class adModel: NSObject {
    var banners: [BangumiBannerModel]?
    var bodys: [BangumiBodyModel]?
    init(banners: [BangumiBannerModel], bodys: [BangumiBodyModel]) {
        self.banners = banners
        self.bodys = bodys
    }
}
class BangumiBannerModel: NSObject {
    var img: String?
    var title: String?
    var uri: String?
    
    init(img: String, title: String, uri: String) {
        self.img = img
        self.title = title
        self.uri = uri
    }
}
class BangumiBodyModel: NSObject {
    var bodyImg: String?
    init(bodyImg: String) {
        self.bodyImg = bodyImg
    }
}
//dic["serializing"]
class BangumiFirstModel: NSObject {
    var cover: String?
    var title: String?
    var watching_count: Int?
    var newest_ep_index: String?
    
    init(cover: String, title: String, watching_count: Int, newest_ep_index: String) {
        self.cover = cover
        self.title = title
        self.watching_count = watching_count
        self.newest_ep_index = newest_ep_index
    }
}
//dic["previous"]
class BangumiSecondModel: NSObject {
    var bangumiSecondDeatils: [BangumiSecondDeatilsModel]?
    init(bangumiSecondDeatils: [BangumiSecondDeatilsModel]) {
        self.bangumiSecondDeatils = bangumiSecondDeatils
    }
}
class BangumiSecondDeatilsModel: NSObject {
    var cover: String?
    var title: String?
    var favourites: String?
    
    init(cover: String, title: String, favourites: String) {
        self.cover = cover
        self.title = title
        self.favourites = favourites
    }
}

