//
//  MusicSetViewHelper.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import CSNetManager
import SwiftyJSON

protocol MusicSetViewCallBackDelegate: NSObjectProtocol {
    func callBackSuccess(manager: CSAPIBaseManager)
    func callBackFailure()
}

class MusicSetViewHelper: NSObject, CSAPIManagerApiCallBackDelegate,CSAPIManagerParamSourceDelegate {
    var musicViewManager: MusicSetViewManager?
    var musicViewRrformer: SerialCartoonViewReformer?
    
    weak var callBackDelegate: MusicSetViewCallBackDelegate?
    var musicViewController: MusicSetViewController?
    var musicModel: SerialCartoonModel?
    
    //刷新数据
    var musicAllManager: MusicSetAllManager?
    var musicAllReformer: SerialAllReformer?
    var musicAllModel: [NewCartoonModel]?
    
    //定义一个变量
    var page: Int?
    
    //MARK: -- life cycle
    override init() {
        super.init()
        
        initManager()
    }
    
    func ApiManager(apiManager: CSAPIBaseManager, finishWithOriginData data: JSON) {
        if apiManager.isKindOfClass(MusicSetViewManager) {
            musicModel = apiManager.fetchData(musicViewRrformer!) as? SerialCartoonModel
            callBackDelegate?.callBackSuccess(apiManager)
        }
        if apiManager.isKindOfClass(MusicSetAllManager) {
            musicAllModel = apiManager.fetchData(musicAllReformer!) as? [NewCartoonModel]
            callBackDelegate?.callBackSuccess(apiManager)
        }
    }
    func ApiManager(apimanager: CSAPIBaseManager, failedWithError error: CSAPIManagerErrorType) {
        callBackDelegate?.callBackFailure()
        switch error {
        case .Timeout:
            YAlertViewController.showAlertController(musicViewController!, title: "提示", message: "网络超时，请稍后重试")
            break
        case .NoNetWork:
            YAlertViewController.showAlertController(musicViewController!, title: "提示", message: "您的网络不太给力，请稍后再试！")
            break
        case .RequestFailed:
            YAlertViewController.showAlertController(musicViewController!, title: "提示", message: "请求失败，请稍后重试")
            break
        default: break
        }
        
    }
    func paramsForApi(manager: CSAPIBaseManager) -> [String : AnyObject] {
        var dic = [String: AnyObject]()
        if manager.isKindOfClass(MusicSetViewManager) {
            
        }
        if manager.isKindOfClass(MusicSetAllManager) {
            dic["pn"] = page
        }
        return dic
    }
    
    //MARK: -- private method
    func initManager() {
        musicViewManager = MusicSetViewManager()
        musicViewRrformer = SerialCartoonViewReformer()
        musicModel = SerialCartoonModel()
        musicViewManager?.callBackDelegate = self
        musicViewManager?.paramSource = self
        
        musicAllManager = MusicSetAllManager()
        musicAllReformer = SerialAllReformer()
        musicAllModel = [NewCartoonModel]()
        musicAllManager?.callBackDelegate = self
        musicAllManager?.paramSource = self
    }
}
