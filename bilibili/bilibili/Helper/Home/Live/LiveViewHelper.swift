//
//  LiveViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/14.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import CSNetManager
import SwiftyJSON

protocol LiveViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class LiveViewHlper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    
    var liveManager: LiveViewManager?
    var liveReformer: LiveViewReformer?
    weak var callBackDelegate: LiveViewCallBackDelegate!
    
    var liveViewController: LiveViewController?
    var liveModel: LiveModel?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        initManager()
    }
    //MARK: -- delegate paraSource
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(LiveViewManager) {
            liveModel = apiManager.fetchData(liveReformer!) as? LiveModel
            callBackDelegate.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(liveViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(liveViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(liveViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        let dic = [String: AnyObject]()
        return dic
    }
    //MARK: -- private method
    func initManager() {
        liveManager = LiveViewManager()
        liveReformer = LiveViewReformer()
        liveManager?.callBackDelegate = self
        liveManager?.paramSource = self
        
        liveModel = LiveModel()
    }
}
