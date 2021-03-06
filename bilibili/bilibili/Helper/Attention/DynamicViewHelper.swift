//
//  DynamicViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/1.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import SwiftyJSON
import CSNetManager

protocol DynamicViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class DynamicViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var dynamicManager: DynamicViewManager?
    var dynamicReformer: DynamicViewReformer?
    var dynamicModel: DynamicModel?
    
    weak var callBackDelegate: DynamicViewCallBackDelegate?
    var dynamicViewController: DynamicViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    //MARK: -- delegate
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(DynamicViewManager) {
            dynamicModel = apiManager.fetchData(dynamicReformer!) as? DynamicModel
            callBackDelegate?.callBackSuccess()
        }
    }
    
    func  ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(dynamicViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(dynamicViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(dynamicViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        dic["pn"] = dynamicModel?.page
        
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        dynamicManager = DynamicViewManager()
        dynamicReformer = DynamicViewReformer()
        dynamicManager?.callBackDelegate = self
        dynamicManager?.paramSource = self
        
        dynamicModel = DynamicModel()
    }
}