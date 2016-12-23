//
//  MineViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol MineViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class MineViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var mineManager: MineViewManager?
    var mineReformer: MineViewReformer?
    var mineModel: MineViewModel?
    weak var callBackDelegate: MineViewCallBackDelegate?
    var mineViewController: MineViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    //MARK: -- delegate
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        mineModel = apiManager.fetchData(mineReformer!) as? MineViewModel
        callBackDelegate?.callBackSuccess()
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(mineViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(mineViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(mineViewController!, title: "提示", message: "请求失败，请稍后重试")
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
        mineManager = MineViewManager()
        mineReformer = MineViewReformer()
        mineModel = MineViewModel()
        mineManager?.callBackDelegate = self
        mineManager?.paramSource = self
    }
}