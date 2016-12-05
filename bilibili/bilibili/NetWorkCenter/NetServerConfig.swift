//
//  NetServerConfig.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/10.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager

//MARK: 设置不同的环境 预上线，上线，测试， 下线
public let kServer = CSServer(serverType: ServerType.OnLine,
                              online: "http://app.bilibili.com",
                              offline: "",
                              prepareOnLine: "",
                              localLine: "")
public let lServer = CSServer(serverType: ServerType.OnLine,
                              online: "http://live.bilibili.com",
                              offline: "",
                              prepareOnLine: "",
                              localLine: "")
public let bServer = CSServer(serverType: ServerType.OnLine,
                              online: "http://bangumi.bilibili.com",
                              offline: "",
                              prepareOnLine: "",
                              localLine: "")
public let aServer = CSServer(serverType: ServerType.OnLine,
                              online: "http://api.bilibili.com",
                              offline: "",
                              prepareOnLine: "",
                              localLine: "")
public let sServer = CSServer(serverType: ServerType.OnLine,
                              online: "http://s.search.bilibili.com",
                              offline: "",
                              prepareOnLine: "",
                              localLine: "")