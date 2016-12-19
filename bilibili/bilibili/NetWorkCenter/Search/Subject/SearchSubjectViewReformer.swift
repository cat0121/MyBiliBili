//
//  SearchSubjectViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

class SearchSubjectViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        let dataJSON = data["data"]["items"]
        
        var searchSubs = [SubModel]()
        for i in 0..<dataJSON.count {
            let subModel = SubModel(cover: dataJSON[i]["cover"].stringValue, title: dataJSON[i]["title"].stringValue, play: dataJSON[i]["play"].intValue, archives: dataJSON[i]["archives"].intValue, desc: dataJSON[i]["desc"].stringValue)
            searchSubs.append(subModel)
        }
        
        let searchSubModel = SearchSubModel(subjects: searchSubs)
        return searchSubModel
    }
}