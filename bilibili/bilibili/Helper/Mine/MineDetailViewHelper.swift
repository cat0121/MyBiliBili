//
//  MineDetailViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol MineDetailViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess()
    func callBackFailure()
}

class MineDetailViewHelper: NSObject, CSAPIManagerApiCallBackDelegate, CSAPIManagerParamSourceDelegate {
    
    var mineManager: MineInfoViewManager?
    var mineReformer: MineInfoViewReformer?
    var mineModel: MineInfoModel?
    weak var callBackDelegate: MineDetailViewCallBackDelegate?
    var mineViewController: MineDetailViewController?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    //MARK: -- delegate
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        mineModel = apiManager.fetchData(mineReformer!) as? MineInfoModel
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
        var dic = [String: AnyObject]()
        dic["name"] = "萌小猫121"
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        mineManager = MineInfoViewManager()
        mineReformer = MineInfoViewReformer()
        mineModel = MineInfoModel()
        mineManager?.callBackDelegate = self
        mineManager?.paramSource = self
    }
}
