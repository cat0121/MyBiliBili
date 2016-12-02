//
//  MarkViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/2.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol MarkViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class MarkViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var markManager: MarkViewManager?
    var markReformer: MarkViewReformer?
    var markModel: MarkModel?
    
    weak var callBackDelegate: MarkViewCallBackDelegate?
    var markViewController: MarkViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    //MARK: -- delegate
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(MarkViewManager) {
            markModel = apiManager.fetchData(markReformer!) as? MarkModel
            callBackDelegate?.callBackSuccess()
        }
    }
    
    func  ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(markViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(markViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(markViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        
        
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        markManager = MarkViewManager()
        markReformer = MarkViewReformer()
        markManager?.callBackDelegate = self
        markManager?.paramSource = self
        
        markModel = MarkModel()
    }

}