//
//  LiveViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/14.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

class LiveViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        if manager.isKindOfClass(LiveViewManager) {
            let dataJSON = data["data"]
            let bannerJSON = dataJSON["banner"]
            let partionsJSON = dataJSON["partitions"]
            //头视图
            var bannerArr = [LiveBannerModel]()
            for i in 0..<bannerJSON.count {
                let bannerModel = LiveBannerModel(img: bannerJSON[i]["img"].stringValue)
                bannerArr.append(bannerModel)
            }
            //body
            var partionsArr = [PartionsModel]()
            for j in 0..<partionsJSON.count {
                //大lives数组
                let detailsJSON = partionsJSON[j]["lives"]
                var partionDetails = [PartionsDetailsModel]()
                for k in 0..<detailsJSON.count {
                    let partionsDetailsModel = PartionsDetailsModel(title: detailsJSON[k]["title"].stringValue, srcImage: detailsJSON[k]["cover"]["src"].stringValue, authorName: detailsJSON[k]["owner"]["name"].stringValue, online: detailsJSON[k]["online"].intValue)
                    partionDetails.append(partionsDetailsModel)
                }
                //大partions数组
                let partionsModel = PartionsModel(srcIcon: partionsJSON[j]["partition"]["sub_icon"]["src"].stringValue, name: partionsJSON[j]["partition"]["name"].stringValue, count: partionsJSON[j]["partition"]["count"].intValue, partionsDetails: partionDetails)
                partionsArr.append(partionsModel)
            }
            let liveModel = LiveModel(banner: bannerArr, partions: partionsArr)
            return liveModel

        }
        return LiveModel()
    }
}