//
//  RecommendViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/10.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

class RecommendViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        if manager.isKindOfClass(RecommendViewManager) {
            let dataJSON = data["data"] //大数组
            
            var recDetails: [RecDetailsModel] = []
            for i in 0..<dataJSON.count {
                let bodyArray = dataJSON[i]["body"].array! //每一个body数组
                var bannerArray: Array<JSON>? //每一个banner数组
                if dataJSON[i]["banner"] != nil {
                    if dataJSON[i]["banner"]["top"].array?.count > 0 {
                        bannerArray = dataJSON[i]["banner"]["top"].array!
                    }else if dataJSON[i]["banner"]["bottom"].array?.count > 0{
                        bannerArray = dataJSON[i]["banner"]["bottom"].array!
                    } else {
                        bannerArray = nil
                    }
                }
                //获取所有的body
                var bodyDetails: [RecBodyModel] = []
                if bodyArray.count > 0 {
                    for j in 0..<bodyArray.count {
                        let bodyModel = RecBodyModel(bodyImage: bodyArray[j]["cover"].stringValue, playcount: bodyArray[j]["play"].intValue, danmaku: bodyArray[j]["danmaku"].intValue, title: bodyArray[j]["title"].stringValue)
                        bodyDetails.append(bodyModel)
                    }
                }
                var bannerDetails: [RecBannerModel] = []
                if bannerArray != nil && bannerArray!.count > 0 {
                    for k in 0..<bannerArray!.count {
                        
                        let bannerModel = RecBannerModel(bannerImage: bannerArray![k]["image"].stringValue, uri: bannerArray![k]["uri"].stringValue)
                        bannerDetails.append(bannerModel)
                    }
                }
                //每一组获取所有的数据
                let recDetailsModel = RecDetailsModel(body: bodyDetails, banner: bannerDetails, headerTitle: dataJSON[i]["title"].stringValue)
                recDetails.append(recDetailsModel)
            }
            
            let recommendModel = RecommendModel(recDetails: recDetails)
            return recommendModel

        }
        return RecommendModel()
    }
    
}
