//
//  SearchResultViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/6.
//  Copyright © 2016年 yan. All rights reserved.
//
//大家都在搜：http://s.search.bilibili.com/main/hotword?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&mobi_app=iphone&platform=ios&sign=7d062f11c90aeb6f39da5b6ad91be94a
//搜索结果页的头：http://app.bilibili.com/x/v2/search/type?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&keyword=夏目友人帐&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=f15b56b9bba7b9a86de04aa6b02b6bc2&ts=1480905680&type=1
//搜索结果页: http://app.bilibili.com/x/v2/search?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&duration=0&keyword=夏目友人帐&mobi_app=iphone&order=default&platform=ios&pn=1&ps=20&rid=0&sign=f2be0e64fb813ccad09ec9ac02fdde8d&ts=1480906803

//搜索出的相关名字：http://api.bilibili.com/suggest?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&main_ver=v3&mobi_app=iphone&platform=ios&sign=35a9c5e4a9b3d64387775de3144fdb55&term=夏目&ts=1480905629（模糊查询）
//专题：http://app.bilibili.com/x/v2/search/type?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&keyword=夏目友人帐&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=e773781d4bf8f079b6ab69e4dd05ecf6&ts=1480905680&type=4
//UP主：http://app.bilibili.com/x/v2/search/type?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&keyword=%E5%A4%8F%E7%9B%AE%E5%8F%8B%E4%BA%BA%E5%B8%90&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=39b1613167cf457994e3cc36cdc1ee0e&ts=1480905680&type=2
//番剧：http://app.bilibili.com/x/v2/search/type?access_key=5f71dfc1dbf6748eb346181690c50df2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3970&device=phone&keyword=%E5%A4%8F%E7%9B%AE%E5%8F%8B%E4%BA%BA%E5%B8%90&mobi_app=iphone&platform=ios&pn=1&ps=20&sign=39b1613167cf457994e3cc36cdc1ee0e&ts=1480905680&type=1
import Foundation
