//
//  SearchSynthesisViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/8.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

class SearchSynthesisViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        if manager.isKindOfClass(SearchSynthesisViewManager) {
            let dataJSON = data["data"]
            let archiveJSON = dataJSON["items"]["archive"]
            let seasonJSON = dataJSON["items"]["season"]
            
            var archives = [ArchiveModel]()
            for i in 0..<archiveJSON.count {
                let archiveModel = ArchiveModel(author: archiveJSON[i]["author"].stringValue, cover: archiveJSON[i]["cover"].stringValue, danmaku: archiveJSON[i]["danmaku"].intValue, play: archiveJSON[i]["play"].intValue, title: archiveJSON[i]["title"].stringValue, duration: archiveJSON[i]["duration"].stringValue)
                archives.append(archiveModel)
            }
            
            var seasons = [SeasonModel]()
            for j in 0..<seasonJSON.count {
                let seasonModel = SeasonModel(cat_desc: seasonJSON[j]["cat_desc"].stringValue, cover: seasonJSON[j]["cover"].stringValue, index: seasonJSON[j]["index"].stringValue, newest_season: seasonJSON[j]["newest_season"].stringValue, title: seasonJSON[j]["title"].stringValue, goto: seasonJSON[j]["goto"].stringValue)
                seasons.append(seasonModel)
            }
            
            let searchSynthesis = SearchSynthesisModel(archives: archives, seasons: seasons)
            return searchSynthesis
        }
        
        return SearchSynthesisModel()
    }
}
