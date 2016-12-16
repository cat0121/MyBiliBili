//
//  FuzzySearchManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import Alamofire

class FuzzySearchManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/suggest?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&main_ver=v3&mobi_app=iphone&platform=ios&sign=35a9c5e4a9b3d64387775de3144fdb55&ts=1480905629"
    }
    //请求方式
    var httpMethod: Alamofire.Method {
        return .GET
    }
    //服务器配置
    var server: CSServer {
        return aServer
    }
    
    override init() {
        super.init()
    }

}
