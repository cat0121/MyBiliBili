//
//  SearchClassifiyViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import Alamofire

class SearchClassifiyViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {//&type=1
        return "/x/v2/search/type?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=39b1613167cf457994e3cc36cdc1ee0e&ts=1480905680"
    }
    //请求方式
    var httpMethod: Alamofire.Method {
        return .GET
    }
    //服务器配置
    var server: CSServer {
        return kServer
    }
    
    override init() {
        super.init()
    }
    
}
