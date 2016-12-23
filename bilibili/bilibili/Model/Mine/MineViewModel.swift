//
//  MineViewModel.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation

class MineViewModel: NSObject {
    
    var face: String?
    var coins: Float?
    var birthday: String?
    var telephone: String?
    var uname: String?
    var sign: String?
    var current_level: Int?
    var current_exp: Int?
    var next_exp: Int?
    var mid: Int?
    var sex: Int?
    
    override init() {
        super.init()
    }
    
    init(face: String, coins: Float, birthday: String, telephone: String, uname: String, sign: String, current_level: Int, current_exp: Int, next_exp: Int, mid: Int, sex: Int) {
        self.face = face
        self.coins = coins
        self.birthday = birthday
        self.telephone = telephone
        self.uname = uname
        self.sign = sign
        self.current_level = current_level
        self.current_exp = current_exp
        self.next_exp = next_exp
        self.mid = mid
        self.sex = sex
    }
}