//
//  ChaseViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/2.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol ChaseViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}
class ChaseViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var chaseManager: ChaseViewManager?
    var chaseReformer: ChaseViewReformer?
    var chaseModel: ChaseModel?
    
    weak var callBackDelegate: ChaseViewCallBackDelegate?
    var chaseViewController: ChaseViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    //MARK: -- delegate
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(ChaseViewManager) {
            chaseModel = apiManager.fetchData(chaseReformer!) as? ChaseModel
            callBackDelegate?.callBackSuccess()
        }
    }
    
    func  ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(chaseViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(chaseViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(chaseViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        let dic = [String :AnyObject]()
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        chaseManager = ChaseViewManager()
        chaseReformer = ChaseViewReformer()
        chaseModel = ChaseModel()
        chaseManager?.callBackDelegate = self
        chaseManager?.paramSource = self
    }
}