//
//  SearchBangumiViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

class SearchBangumiViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        let dataJSON = data["data"]["items"]
        
        var searchBans = [SeasonModel]()
        for i in 0..<dataJSON.count {
            let bangumiModel = SeasonModel(cat_desc: dataJSON[i]["cat_desc"].stringValue, cover: dataJSON[i]["cover"].stringValue, index: dataJSON[i]["index"].stringValue, newest_season: dataJSON[i]["newest_season"].stringValue, title: dataJSON[i]["title"].stringValue, goto: dataJSON[i]["goto"].stringValue)
            searchBans.append(bangumiModel)
        }
        
        let searchBanModel = SearchBanModel(bangumi: searchBans)
        return searchBanModel
    }
}
