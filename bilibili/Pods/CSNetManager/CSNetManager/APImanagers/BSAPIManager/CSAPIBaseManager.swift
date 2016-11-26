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
import SwiftyJSON
import Haneke
import RealReachability

public enum CSAPIManagerErrorType : Int {
    case Default      //没有产生过API请求，这个是manager的默认状态。
    case Success      //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    case NoContent    //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    case ParamsError  //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    case Timeout      //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    case NoNetWork    //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
    case RequestFailed //请求失败，用于无法区分请求失败是因为参数不符和请求超时
}

public class CSAPIBaseManager: NSObject{
    // 服务器请求成功后返回的key
    static let successKey = "success"
    static let successValue = 1
    
    // CSAPIBaseManager的子类，必须遵守CSAPIManagerDelegate协议。
    private weak var child: CSAPIManagerDelegate?
    // 请求
    private var request: Request?
    // 请求返回的数据
    //    private var data: [String: AnyObject]?
    private var data: SwiftyJSON.JSON!
    // 请求URL
    private var urlString: String?
    // 请求参数
    private var paramsDic: [String: AnyObject]?
    // 是否正在进行网络请求
    var isLoading = false
    // 请求超时设置
    public var timeoutInterval: NSTimeInterval = 20
    // 是否开启缓存
    public var shouldAutoCacheResultWhenSuccess: Bool = false
    // 请求成功代理
    public weak var callBackDelegate: CSAPIManagerApiCallBackDelegate?
    // 请求参数代理
    public weak var paramSource: CSAPIManagerParamSourceDelegate?
    // 缓存类型
    let cache = Shared.dataCache
    // 显示菊花的View
    public var showHUDView: UIView!
    
    // MARK: Initialization
    public override init() {
        super.init()
        // CSAPIBaseManager的子类，必须遵守CSAPIManagerDelegate协议,否则直接进断言
        if self is CSAPIManagerDelegate {
            self.child = (self as! CSAPIManagerDelegate)
        }else {
            assert(false, "ApiManager's subclass must conform the APIManagerDelegate")
        }
    }
    // manager使用reformer来处理请求成功后的数据
    public func fetchData(reformer: CSReformer)-> AnyObject{
        let resultData = reformer.reformData(self, data: self.data!)
        return resultData
    }
    // 加载数据
    public func loadData() {
        // 获取请求参数
        paramsDic = self.paramSource!.paramsForApi(self)
        // 判断该manager是否正在请求
        if self.isLoading {
            return
        }
        // 如果开启缓存,到缓存里面取数据
        if self.shouldAutoCacheResultWhenSuccess {
            cache.fetch(key: self.apiURLString())
                .onSuccess { data in
                    do {
                        let dic = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                        self.data = JSON(dic)
                    }catch {
                        
                    }
                    self.callBackDelegate?.ApiManager(self, finishWithOriginData: self.data)
                    return
                }
                .onFailure({ (error: NSError?) -> () in
                    self.netRequest()
                    return
                })
        }else {
            netRequest()
        }
    }
    
    private func netRequest() {
        self.isLoading = true
        // RealReachability进行真实网络判断
        RealReachability.sharedInstance().currentReachabilityStatus()
        RealReachability.sharedInstance().reachabilityWithBlock { (status:ReachabilityStatus) -> Void in
            if status == ReachabilityStatus.RealStatusNotReachable {
                self.callBackDelegate?.ApiManager(self, failedWithError: CSAPIManagerErrorType.NoNetWork)
                // 网络请求结束
                self.isLoading = false
                return
            }
            // Manager进行网络请求前,取消之前的网络请求
            self.cancel()
            // 根据URL以及参数获取到请求的Request
            self.request = CSRequestGenerator.generateRequestWithAPI(self, method: self.child!.httpMethod, params: self.paramsDic!)
            // 设置超时时间
            self.request?.session.configuration.timeoutIntervalForRequest = self.timeoutInterval
            // 请求获取JSON数据
            self.request?.responseJSON{ response in
                // 网络请求结束
                self.isLoading = false
                
                if response.result.error != nil {
                    // 网络请求失败,超时和参数错误
                    self.callBackDelegate?.ApiManager(self, failedWithError: CSAPIManagerErrorType.RequestFailed)
                }else if response.result.value != nil {
                    
                    let value = JSON(response.result.value!)
                    // 网络请求成功，返回数据
                    self.data = value
                    self.callBackDelegate?.ApiManager(self, finishWithOriginData: self.data)
                    
                    // 缓存存储
                    if self.shouldAutoCacheResultWhenSuccess {
                        let dic = response.result.value
                        var data: NSData?
                        do {
                            data = try NSJSONSerialization.dataWithJSONObject(dic!, options: NSJSONWritingOptions.PrettyPrinted)
                            self.cache.set(value:data!, key: self.apiURLString())
                        }catch {
                            
                        }
                    }
                    //                    // 根据具体的服务器返回的判断是否成功的key和Value来判断
                    //                    if value[CSAPIBaseManager.successKey] as! Int == CSAPIBaseManager.successValue {
                    //                        self.callBackDelegate?.ApiManager(self, finishWithOriginData: value)
                    //                    }else {
                    //                        // TODO: 参数问题
                    //                        self.callBackDelegate?.ApiManager(self, failedWithError: CSAPIManagerErrorType.ParamsError)
                    //                    }
                }
//                else {
//                    // 未知错误
//                    self.callBackDelegate?.ApiManager(self, failedWithError: CSAPIManagerErrorType.Timeout)
//                }
            }
        }
    }
    
    // 取消请求
    func cancel() -> Void {
        self.request?.cancel()
    }
    // 获取请求的数据
    func originData() -> SwiftyJSON.JSON? {
        return self.data
    }
    
    // TODO:获取API 缺少 RTAPIManagerValidator API的校验环节
    func apiURLString() -> String {
        if self.child!.apiVersion.isEmpty {
            self.urlString = self.child!.server.url + self.child!.apiName
        }else {
            self.urlString = self.child!.server.url + "/" + self.child!.apiVersion + "/" + self.child!.apiName
        }
        return self.urlString!
    }
}


