//
//  MineInfoViewReformer.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import SwiftyJSON
import CSNetManager

class MineInfoViewReformer: CSReformer {
    func reformData(manager: CSAPIBaseManager, data: JSON) -> AnyObject {
        let dataJSON = data["data"]
        let tagJSON = dataJSON["tag"]
        let favouriteJSON = dataJSON["favourite"]["item"]
        let seasonJSON = dataJSON["season"]["item"]
        
        //tag
        var tags = [TagModel]()
        for i in 0..<tagJSON.count {
            let tagModel = TagModel(tag_name: tagJSON[i]["tag_name"].stringValue)
            tags.append(tagModel)
        }
        
        //favourite
        var favourites = [FavouriteItem]()
        for j in 0..<favouriteJSON.count {
            for n in 0..<favouriteJSON[j]["cover"].count {
                let favouriteItem = FavouriteItem(name: favouriteJSON[j]["name"].stringValue, cur_count: favouriteJSON[j]["cur_count"].intValue, pic: favouriteJSON[j]["cover"][n]["pic"].stringValue)
                favourites.append(favouriteItem)
            }
        }
        let favouriteModel = FavouriteModel(item: favourites)
        
        //season
        var seasons = [SeasonItem]()
        for k in 0..<seasonJSON.count {
            let seasonItem = SeasonItem(cover: seasonJSON[k]["cover"].stringValue, title: seasonJSON[k]["title"].stringValue, newest_ep_index: seasonJSON[k]["newest_ep_index"].stringValue, total_count: seasonJSON[k]["total_count"].stringValue)
            seasons.append(seasonItem)
        }
        let seasonModel = MineSeasonModel(item: seasons)
        
        let mineInfo = MineInfoModel(tag: tags, favourite: favouriteModel, season: seasonModel)
        
        return mineInfo
    }
}
