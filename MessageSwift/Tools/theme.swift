//
//  theme.swift
//  MessageSwift
//
//  Created by 曹云霄 on 16/3/14.
//  Copyright © 2016年 caoyunxiao. All rights reserved.
//

import UIKit


//MARK: -全局常用属性
public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let SHARED_APPDELEGATE: UIApplicationDelegate = UIApplication.sharedApplication().delegate!
public let LeftVCWidth: CGFloat = 250





//MARK: -聚合数据Openid
public let OPENID: String = "JH59eb5bfa8ac7cd1b84ca038f53790390"



//MARK: -查询身份证信息网址
public let CarIDurl: String = "http://apis.juhe.cn/idcard/index"
//MARK: -身份证KEY
public let CarIDKEY: String = "fee6750482d71c0e4626a0c481459676"
//MARK: -快递公司编号
public let Kuaidiurl: String = "http://v.juhe.cn/exp/com"
//MARK: -快递KEY
public let KuaidiKEY: String = "6019f25074ae1cbe924616ccca8b9901"
//MARK: -查询快递编号
public let QueryURL: String = "http://v.juhe.cn/exp/index"
//MARK: -笑话接口
public let JokeUrl: String = "http://japi.juhe.cn/joke/content/list.from"
//MARK: -笑话KEY
public let JokeKEY: String = "bbd177c135c258966f9bbe41e6bae598"