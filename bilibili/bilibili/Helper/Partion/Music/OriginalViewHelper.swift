//
//  OriginalViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol OriginalViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class OriginalViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var originalManager: OriginalViewManager?
    var originalViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: OriginalViewCallBackDelegate?
    var originalViewController: OriginalViewController?
    var originalModel: SerialCartoonModel?
    
    //刷新数据
    var originalAllManager: OriginalAllManager?
    var originalAllReformer: SerialAllReformer?
    var originalAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(OriginalViewManager) {
            originalModel = apiManager.fetchData(originalViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(OriginalAllManager) {
            originalAllModel = apiManager.fetchData(originalAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(originalViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(originalViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(originalViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(OriginalViewManager) {
            
        }
        if manager.isKindOfClass(OriginalAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        originalManager = OriginalViewManager()
        originalViewRrformer = SerialCartoonViewReformer()
        originalModel = SerialCartoonModel()
        originalManager?.callBackDelegate = self
        originalManager?.paramSource = self
        
        originalAllManager = OriginalAllManager()
        originalAllReformer = SerialAllReformer()
        originalAllModel = [NewCartoonModel]()
        originalAllManager?.callBackDelegate = self
        originalAllManager?.paramSource = self
    }
}

