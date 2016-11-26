//
//  BangumiViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

class BangumiViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        
        if manager.isKindOfClass(BangumiViewManager) {
            let dataJSON = data["result"]
            //dic["ad"]
            let adJSON = dataJSON["ad"]
            var bodys = [BangumiBodyModel]()
            for i in 0..<adJSON["body"].count {
                let bangumiBodyModel = BangumiBodyModel(bodyImg: adJSON["body"][i]["img"].stringValue)
                bodys.append(bangumiBodyModel)
            }
            var banners = [BangumiBannerModel]()
            for j in 0..<adJSON["head"].count {
                let bangumiBannerModel = BangumiBannerModel(img: adJSON["head"][j]["img"].stringValue)
                banners.append(bangumiBannerModel)
            }
            let ad = adModel(banners: banners, bodys: bodys)
            //dic["previous"]
            let secondJSON = dataJSON["previous"]["list"]
            var secondArr = [BangumiSecondDeatilsModel]()
            for k in 0..<secondJSON.count {
                let secondModel = BangumiSecondDeatilsModel(cover: secondJSON[k]["cover"].stringValue, title: secondJSON[k]["title"].stringValue, favourites: secondJSON[k]["favourites"].stringValue)
                secondArr.append(secondModel)
            }
            let secondModels = BangumiSecondModel(bangumiSecondDeatils: secondArr)
            //dic["serializing"]
            let firstJSON = dataJSON["serializing"]
            var firstArr = [BangumiFirstModel]()
            for l in 0..<firstJSON.count {
                let firstModel = BangumiFirstModel(cover: firstJSON[l]["cover"].stringValue, title: firstJSON[l]["title"].stringValue, watching_count: firstJSON[l]["watching_count"].intValue, newest_ep_index: firstJSON[l]["newest_ep_index"].stringValue)
                firstArr.append(firstModel)
            }
            let bangumiModel = BangumiModel(admodel: ad, bangumiSecondModel: secondModels, bangumiFirstModel: firstArr)
            return bangumiModel

        }
        return BangumiModel()
    }
}