//
//  BangumiViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol BangumiViewCallBackDelagate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class BangumiViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var bangumiManager: BangumiViewManager?
    var bangumiReformer: BangumiViewReformer?
    weak var callBackDelegate: BangumiViewCallBackDelagate?
    
    var bangumiController: BangumiViewController?
    var bangumiModel: BangumiModel?
    
    //MARK: --  life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    //MARK: -- delegate
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(BangumiViewManager) {
            bangumiModel = apiManager.fetchData(bangumiReformer!) as? BangumiModel
            callBackDelegate?.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(bangumiController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(bangumiController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(bangumiController!, title: "提示", message: "请求失败，请稍后重试")
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
        bangumiManager = BangumiViewManager()
        bangumiReformer = BangumiViewReformer()
        bangumiManager?.callBackDelegate = self
        bangumiManager?.paramSource = self
        
        bangumiModel = BangumiModel()
    }
}