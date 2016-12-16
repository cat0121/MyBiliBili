//
//  FuzzySearchReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

class FuzzySearchReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        if manager.isKindOfClass(FuzzySearchManager) {
//            var searchDic = Dictionary<String, EachModel>()
            var eachData = [EachModel]()
            for i in 0..<10 {
                let string = String.init(format: "%d", i)
                let dataJSON = data[string]
                let eachModel = EachModel(name: dataJSON["name"].stringValue)
                eachData.append(eachModel)
//                searchDic[string] = eachModel
            }
            let fuzzySearch = FuzzySearchModel(eachData: eachData)
            return fuzzySearch
        }
        return FuzzySearchModel()
    }
}