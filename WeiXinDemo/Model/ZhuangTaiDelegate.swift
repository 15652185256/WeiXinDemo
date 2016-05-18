//
//  ZhuangTaiDelegate.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/18.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import Foundation

//状态代理协议
protocol ZhuangTaiDelegate {
    func isOn(zt:ZhuangTai)
    func isOff(zt:ZhuangTai)
    func meOff()
}