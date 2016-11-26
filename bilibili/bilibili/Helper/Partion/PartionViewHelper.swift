//
//  PartionViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/17.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol PartionViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class PartionViewHlper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var partionViewManager: PartionViewManager?
    var partionViewRrformer: PartionViewReformer?
    
    weak var callBackDelegate: PartionViewCallBackDelegate?
    var partionModel: [PartionModel]?
    var partionController: PartionViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        partionModel = apiManager.fetchData(partionViewRrformer!) as? [PartionModel]
        callBackDelegate?.callBackSuccess()
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(partionController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(partionController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(partionController!, title: "提示", message: "请求失败，请稍后重试")
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
        partionViewManager = PartionViewManager()
        partionViewRrformer = PartionViewReformer()
        partionViewManager?.callBackDelegate = self
        partionViewManager?.paramSource = self
        
        partionModel = [PartionModel]()
    }
}

