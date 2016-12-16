//
//  SearchBangumiViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

protocol SearchBangumiViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class SearchBangumiViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var bangumiManager: SearchClassifiyViewManager?
    var bangumiReformer: SearchBangumiViewReformer?
    var searchBanModel: SearchBanModel?
    
    weak var callBackDelegate: SearchBangumiViewCallBackDelegate?
    var bangumiViewController: SearchBangumiViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(SearchClassifiyViewManager) {
            searchBanModel = apiManager.fetchData(bangumiReformer!) as? SearchBanModel
            callBackDelegate?.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(bangumiViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(bangumiViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(bangumiViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        dic["pn"] = searchBanModel!.page
        dic["keyword"] = searchBanModel!.keyword
        dic["type"] = 1
        
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        bangumiManager = SearchClassifiyViewManager()
        bangumiReformer = SearchBangumiViewReformer()
        searchBanModel = SearchBanModel()
        bangumiManager?.callBackDelegate = self
        bangumiManager?.paramSource = self
    }
    
}

