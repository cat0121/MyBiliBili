//
//  MarkViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/2.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

class MarkViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        if manager.isKindOfClass(MarkViewManager) {
            let dataJSON = data["data"]
            let feedsJSON = dataJSON["feeds"]
            
            var additionArr = [AdditionModel]()
            for i in 0..<feedsJSON.count {
                let additionModel = AdditionModel(title: feedsJSON[i]["addition"]["title"].stringValue, pic: feedsJSON[i]["addition"]["pic"].stringValue, UP: feedsJSON[i]["addition"]["author"].stringValue, play: feedsJSON[i]["addition"]["play"].intValue, danmaku: feedsJSON[i]["addition"]["video_review"].intValue)
                additionArr.append(additionModel)
            }
            
            let markModel = MarkModel(additions: additionArr, page: dataJSON["page"]["num"].intValue)
            return markModel
        }
        return MarkModel()
    }
}