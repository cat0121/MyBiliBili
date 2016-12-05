//
//  EveryoneSearchManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/5.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import Alamofire

class EveryoneSearchManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/main/hotword?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&sign=7d062f11c90aeb6f39da5b6ad91be94a"
    }
    //请求方式
    var httpMethod: Alamofire.Method {
        return .GET
    }
    //服务器配置
    var server: CSServer {
        return sServer
    }
    
    override init() {
        super.init()
    }
    
}
