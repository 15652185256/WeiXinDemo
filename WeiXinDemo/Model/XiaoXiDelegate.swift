//
//  XiaoXiDelegate.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/18.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import Foundation

//消息代理协议
protocol XiaoXiDelegate {
    func newMsg(aMsg:WXMessage)
}