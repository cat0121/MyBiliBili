//  CSServer.swift
//
//  Copyright (c) 2016 LiChangsong
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

// 服务器类型
public enum ServerType : Int{
    case OnLine = 0
    case OffLine = 1
    case PrepareOnLine = 2
    case LocalLine = 3
}

public class CSServer : NSObject {
    // 设置当前服务器环境
    private var serverType: ServerType
    // 线上环境地址
    private var onlineURL: String
    // 离线环境地址
    private var offlineURL: String
    // 预上线线环境地址
    private var prepareOnLineURL: String
    // 本地环境地址
    private var localLineURL: String
    
    var url: String {
        get {
            switch serverType {
            case ServerType.OnLine :
                return self.onlineURL
            case ServerType.OffLine :
                return self.offlineURL
            case ServerType.PrepareOnLine :
                return self.prepareOnLineURL
            case ServerType.LocalLine :
                return self.localLineURL            }
        }
    }
    public init(serverType: ServerType, online: String, offline: String, prepareOnLine: String, localLine: String) {
        self.serverType = serverType
        self.onlineURL = online
        self.offlineURL = offline
        self.prepareOnLineURL = prepareOnLine
        self.localLineURL = localLine
        super.init()
    }
}



