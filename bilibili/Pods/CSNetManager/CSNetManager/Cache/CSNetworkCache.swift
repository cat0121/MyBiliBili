//
//  CSNetworkCache.swift
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

//import Foundation
//import KMCache
//// 暂时不用改缓存方案改用HanekeSwift
//class CSNetworkCache: NSObject {
//    
//    static let memoryCache = CSNetworkCache()
//    private let cache = KMCache(type: .ReleaseByTime)
//    
//    override init() {
//        super.init()
//        
//        self.cache.needRefreshCacheWhenUsed = true
//        self.cache.maxCount = 2000
//    }
//    // 根据key存储缓存
//    func setObject(object: NSObjectProtocol, forKey key: NSObjectProtocol) {
//        self.cache.setCacheObject(object, forKey: key)
//    }
//    // 根据key获取缓存
//    func objectForKey(key: NSObjectProtocol) -> NSObjectProtocol? {
//        return self.cache.objectForKey(key)
//    }
//    
//    func size() -> UInt {
//        return self.cache.size()
//    }}
