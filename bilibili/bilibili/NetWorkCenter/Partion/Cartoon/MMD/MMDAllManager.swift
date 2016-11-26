//
//  MMDAllManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import Alamofire

class MMDAllManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/x/v2/region/show/child/list?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&rid=25&sign=ab67728087927dea174a4eabba351e6c&ts=1479867769"
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

