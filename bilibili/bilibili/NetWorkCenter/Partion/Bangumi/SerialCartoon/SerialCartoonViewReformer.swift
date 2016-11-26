//
//  SerialCartoonViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import SwiftyJSON
import CSNetManager

class SerialCartoonViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        let dataJSON = data["data"]
        
        let recommndJSON = dataJSON["recommend"]
        var recommends = [RecCartoonModel]()
        for i in 0..<recommndJSON.count {
            let recommendModel = RecCartoonModel(cover: recommndJSON[i]["cover"].stringValue, title: recommndJSON[i]["title"].stringValue, name: recommndJSON[i]["name"].stringValue, play: recommndJSON[i]["play"].intValue, danmaku: recommndJSON[i]["danmaku"].intValue)
            recommends.append(recommendModel)
        }
        
        let newJSON = dataJSON["new"]
        var news = [NewCartoonModel]()
        for j in 0..<newJSON.count {
            let newCartoon = NewCartoonModel(cover: newJSON[j]["cover"].stringValue, title: newJSON[j]["title"].stringValue, name: newJSON[j]["name"].stringValue, play: newJSON[j]["play"].intValue, danmaku: newJSON[j]["danmaku"].intValue)
            news.append(newCartoon)
        }
        
        let serialCartoon = SerialCartoonModel(recCartoon: recommends, newCartoon: news)
        return serialCartoon
    }
}