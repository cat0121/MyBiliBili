//
//  SearchViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/5.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

protocol SearchViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class SearchViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var everyoneManager: EveryoneSearchManager?
    var everyoneReformer: EveryoneSearchReformer?
    var everyModel: EveryonSearchModel?
    
    weak var callBackDelegate: SearchViewCallBackDelegate?
    var searchViewController: SearchViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(EveryoneSearchManager) {
            everyModel = apiManager.fetchData(everyoneReformer!) as? EveryonSearchModel
            callBackDelegate?.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(searchViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(searchViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(searchViewController!, title: "提示", message: "请求失败，请稍后重试")
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
        everyoneManager = EveryoneSearchManager()
        everyoneReformer = EveryoneSearchReformer()
        everyModel = EveryonSearchModel()
        everyoneManager?.callBackDelegate = self
        everyoneManager?.paramSource = self
    }
}
