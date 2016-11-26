//
//  CartoonRecommendReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

class CartoonRecommendReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        
            let dataJSON = data["data"]
            //轮播图
            let bannerJSON = dataJSON["banner"]["top"]
            var banners = [RecBannerModel]()
            for i in 0..<bannerJSON.count {
                let bannerModel = RecBannerModel(bannerImage: bannerJSON[i]["image"].stringValue, uri: bannerJSON[i]["uri"].stringValue)
                banners.append(bannerModel)
            }
            //热门推荐
            let recommendJSON = dataJSON["recommend"]
            var recommends = [RecBodyModel]()
            for j in 0..<recommendJSON.count {
                let recommendModel = RecBodyModel(bodyImage: recommendJSON[j]["cover"].stringValue, playcount: recommendJSON[j]["play"].intValue, danmaku: recommendJSON[j]["danmaku"].intValue, title: recommendJSON[j]["title"].stringValue)
                recommends.append(recommendModel)
            }
            //最新投稿
            let newJSON = dataJSON["new"]
            var news = [RecBodyModel]()
            for k in 0..<newJSON.count {
                let newModel = RecBodyModel(bodyImage: newJSON[k]["cover"].stringValue, playcount: newJSON[k]["play"].intValue, danmaku: newJSON[k]["danmaku"].intValue, title: newJSON[k]["title"].stringValue)
                news.append(newModel)
            }
            //全区动态
            let dynamicJSON = dataJSON["dynamic"]
            var dynamics = [RecBodyModel]()
            for l in 0..<dynamicJSON.count {
                let dynamicModel = RecBodyModel(bodyImage: dynamicJSON[l]["cover"].stringValue, playcount: dynamicJSON[l]["play"].intValue, danmaku: dynamicJSON[l]["danmaku"].intValue, title: dynamicJSON[l]["title"].stringValue)
                dynamics.append(dynamicModel)
            }
            //全部数据
            let cartoonRecommend = CartoonRecommendModel(banner: banners, dynamic: dynamics, new: news, recommend: recommends)
            return cartoonRecommend
        
    }
}
