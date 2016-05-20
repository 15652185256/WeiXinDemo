//
//  WXMessage.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/17.
//  Copyright © 2016年 ZXD. All rights reserved.
//

//微信消息类
import Foundation

//聊天消息
struct WXMessage {
    var body = "" //内容
    var from = "" //来源
    var isComposing = false //是否正在输入
    var isDelay = false     //是否离线
    var isMe = false        //是否是我发的
}

//好友状态
struct ZhuangTai {
    var name = ""     //谁
    var isOnline = false   //在线状态
}

//获取正确的删除索引
func getRemoveIndex(a: String,aArray: [WXMessage]) -> [Int] {
    
    var indexArray = [Int]()
    var orderArray = [Int]()
    
    //元素在数组中的索引
    for (index, x) in aArray.enumerate(){
        if a == x.from {
            indexArray.append(index)
        }
    }
    
    //正确的删除索引
    for (index,x) in indexArray.enumerate() {
        
        let y = x - index //原索引减去在当前数组中的索引
        orderArray.append(y)
    }
    
    return orderArray
}

//把指定的消息从数组中全部删除
func removeValueFromArray(s1:String,inout aArray: [WXMessage]) {
    
    //print("aArray:\(aArray.count)")
    
    //获取正确的删除顺序
    let indexArray = getRemoveIndex(s1, aArray: aArray)
    
    for i in indexArray {
        
        aArray.removeAtIndex(i)
        
    }
    
}