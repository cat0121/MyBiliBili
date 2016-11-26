//
//  RecommendViewHepler.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/10.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol RecommendViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class RecommendViewHepler: NSObject,CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    
    var recManager: RecommendViewManager?
    var recReformer: RecommendViewReformer?
    var recModel: RecommendModel?
    var recommendViewController: RecommendViewController?
    //创建一个代理
    weak var callBackDelegate: RecommendViewCallBackDelegate?
    
    //MARK: -- Delegate ParamSource
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(RecommendViewManager) {
            recModel = apiManager.fetchData(recReformer!) as? RecommendModel
            callBackDelegate?.callBackSuccess()
        }
        
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(recommendViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(recommendViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(recommendViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        let dic = [String: AnyObject]()
        
        return dic
    }
    
    override init() {
        super.init()
        
        initManager()
    }
    //MARK: -- private method
    func initManager() {
        recManager = RecommendViewManager()
        recReformer = RecommendViewReformer()
        recModel = RecommendModel()
        recManager?.callBackDelegate = self
        recManager?.paramSource = self
    }
}
