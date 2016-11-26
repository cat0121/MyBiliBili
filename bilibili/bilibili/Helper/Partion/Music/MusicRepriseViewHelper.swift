//
//  MusicRepriseViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol MusicRepriseViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class MusicRepriseViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var musicRepriseManager: MusicRepriseViewManager?
    var musicRepriseViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: MusicRepriseViewCallBackDelegate?
    var musicRepriseViewController: MusicRepriseViewController?
    var musicRepriseModel: SerialCartoonModel?
    
    //刷新数据
    var musicRepriseAllManager: MusicRepriseAllManager?
    var musicRepriseAllReformer: SerialAllReformer?
    var musicRepriseAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(MusicRepriseViewManager) {
            musicRepriseModel = apiManager.fetchData(musicRepriseViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(MusicRepriseAllManager) {
            musicRepriseAllModel = apiManager.fetchData(musicRepriseAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(musicRepriseViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(musicRepriseViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(musicRepriseViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(MusicRepriseViewManager) {
            
        }
        if manager.isKindOfClass(MusicRepriseAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        musicRepriseManager = MusicRepriseViewManager()
        musicRepriseViewRrformer = SerialCartoonViewReformer()
        musicRepriseModel = SerialCartoonModel()
        musicRepriseManager?.callBackDelegate = self
        musicRepriseManager?.paramSource = self
        
        musicRepriseAllManager = MusicRepriseAllManager()
        musicRepriseAllReformer = SerialAllReformer()
        musicRepriseAllModel = [NewCartoonModel]()
        musicRepriseAllManager?.callBackDelegate = self
        musicRepriseAllManager?.paramSource = self
    }
}
