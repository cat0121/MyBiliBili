//
//  MarkViewManager.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/2.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import Alamofire

class MarkViewManager: CSAPIBaseManager,CSAPIManagerDelegate {
    //版本号
    var apiVersion: String {
        return ""
    }
    //请求URL
    var apiName: String {
        return "/x/feed/pull?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=e5feee8f0cfab2090979dab87e17c782&ts=1480569537&type=2"
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
