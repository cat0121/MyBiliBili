
//  CSAPIBaseManager.swift
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
import Alamofire

class CSRequestGenerator: NSObject {
    
    class func generateRequestWithAPI(api: CSAPIBaseManager, method: Alamofire.Method, params: [String: AnyObject]) -> Request {
        // 网络请求的参数格式处理，获取请求的Request
//        let request = Manager.sharedInstance.request(method, api.apiURLString(), parameters: params, encoding: .URL, headers: nil)
        let request = Manager.sharedInstance.request(method, api.apiURLString(), parameters: ["json":NSData.jsonString(params)!], encoding: .URL, headers: nil)
        return request
    }
}

extension NSData {
    // 将字典转换成JSON字符串
    class func jsonString(jsonDictionary: [String:AnyObject]) -> String? {
        do {
            let  data  = try NSJSONSerialization.dataWithJSONObject(jsonDictionary, options: NSJSONWritingOptions())
            let strJson = NSString(data: data, encoding: NSUTF8StringEncoding)
            return strJson as? String
        } catch {
            // No-op
        }
        return ""
    }
}