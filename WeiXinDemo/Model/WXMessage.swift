//
//  WXMessage.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/17.
//  Copyright © 2016年 ZXD. All rights reserved.
//

//微信消息类
import Foundation

//好友消息结构
struct WXMessage {
    var body = "" //内容
    var from = "" //来源
    var isComposing = false //是否正在输入
    var isDelay = false     //是否离线
    var isMe = false        //是否是我发的
}

//状态结构
struct ZhuangTai {
    var name = ""     //谁
    var isOnline = false   //在线状态
}
