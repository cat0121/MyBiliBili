//
//  RecommendViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/10.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import Alamofire

class RecommendViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/x/v2/show?access_key=986a5e5c71e98920fe6bab0e791c2d39&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3940&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=823429d71888e2a420151535f0318afa&ts=1478742761&warm=0"
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
