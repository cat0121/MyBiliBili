//
//  SearchUPViewHelper.swift
//  bilibili
//
//  Created by ShuYan Feng on 2016/12/17.
//  Copyright © 2016年 yan. All rights reserved.
//

import CSNetManager
import SwiftyJSON

protocol SearchUPViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class SearchUPViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var UPManager: SearchClassifiyViewManager?
    var UPReformer: SearchUPViewReformer?
    var searchUPModel: SearchUPModel?
    
    weak var callBackDelegate: SearchUPViewCallBackDelegate?
    var UPViewController: SearchUPViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(SearchClassifiyViewManager) {
            searchUPModel = apiManager.fetchData(UPReformer!) as? SearchUPModel
            callBackDelegate?.callBackSuccess()
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(UPViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(UPViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(UPViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        dic["pn"] = searchUPModel!.page
        dic["keyword"] = searchUPModel!.keyword
        dic["type"] = 2
        
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        UPManager = SearchClassifiyViewManager()
        UPReformer = SearchUPViewReformer()
        searchUPModel = SearchUPModel()
        UPManager?.callBackDelegate = self
        UPManager?.paramSource = self
    }
    
}