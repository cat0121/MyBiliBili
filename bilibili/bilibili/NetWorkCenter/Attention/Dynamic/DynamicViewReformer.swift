//
//  DynamicViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/1.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import SwiftyJSON
import CSNetManager

class DynamicViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        if manager.isKindOfClass(DynamicViewManager) {
            let dataJSON = data["result"]
            
            var dynamicArr = [DynamicVideos]()
            for i in 0..<dataJSON.count {
                var dynamicVideosJSON = dataJSON[i]["videos"]
                //video数组
                var dynamicVideosArr = [DynamicVideoModel]()
                for j in 0..<dynamicVideosJSON.count {
                    let dynamicVideo = DynamicVideoModel(cover: dynamicVideosJSON[j]["cover"].stringValue, title: dynamicVideosJSON[j]["title"].stringValue)
                    dynamicVideosArr.append(dynamicVideo)
                }
                let dynamicVideos = DynamicVideos(avatar: dataJSON[i]["avatar"].stringValue, fans: dataJSON[i]["fans"].intValue, name: dataJSON[i]["name"].stringValue, video: dynamicVideosArr)
                
                dynamicArr.append(dynamicVideos)
            }
            let dynamicModel = DynamicModel(videos: dynamicArr)
            return dynamicModel
        }
        
        return DynamicModel()
    }
}