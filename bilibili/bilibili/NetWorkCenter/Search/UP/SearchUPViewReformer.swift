//
//  SearchUPViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

class SearchUPViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        let dataJSON = data["data"]["items"]
        
        var searchUPs = [UPModel]()
        for i in 0..<dataJSON.count {
            let upModel = UPModel(cover: dataJSON[i]["cover"].stringValue, title: dataJSON[i]["title"].stringValue, fans: dataJSON[i]["fans"].intValue, archives: dataJSON[i]["archives"].intValue, sign: dataJSON[i]["sign"].stringValue)
            searchUPs.append(upModel)
        }
        
        let searchUPModel = SearchUPModel(ups: searchUPs)
        return searchUPModel
    }
}

