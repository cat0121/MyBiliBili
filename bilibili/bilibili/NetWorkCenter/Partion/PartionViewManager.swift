//
//  PartionViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/17.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import Alamofire

class PartionViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/x/v2/region?access_key=986a5e5c71e98920fe6bab0e791c2d39&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3940&device=phone&mobi_app=iphone&platform=ios&sign=cf44106fa1ce10d8213659fe872119d5&ts=1479115671"
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