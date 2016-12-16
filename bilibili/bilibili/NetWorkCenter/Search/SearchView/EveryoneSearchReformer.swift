//
//  EveryoneSearchReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/5.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

class EveryoneSearchReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        if manager.isKindOfClass(EveryoneSearchManager) {
            let dataJSON = data["list"]
            var keywordArr = [KeywordModel]()
            
            for i in 0..<dataJSON.count {
                let keywordModel = KeywordModel(keyword: dataJSON[i]["keyword"].stringValue)
                keywordArr.append(keywordModel)
            }
            let everyoneSearchModel = EveryonSearchModel(keywords: keywordArr)
            return everyoneSearchModel
        }
        return EveryonSearchModel()
    }
}