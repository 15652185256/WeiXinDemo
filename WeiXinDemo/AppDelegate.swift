//
//  AppDelegate.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/17.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, XMPPStreamDelegate {

    var window: UIWindow?
    
    //通道
    var xs : XMPPStream?
    //服务器是否开启
    var isOPen = false
    //密码
    var pwd = ""
    
    //好友状态代理
    var ztdl : ZhuangTaiDelegate?
    //微信消息代理
    var xxdl : XiaoXiDelegate?
    
    
    
    
    
    
    
    //建立通道
    func buildStream()  {
        xs = XMPPStream()
        print("building Stream")
        xs!.addDelegate(self, delegateQueue: dispatch_get_main_queue())
    }
    
    //通道代理方法: 已经连接上
    func xmppStreamDidConnect(sender: XMPPStream!){
        print("connected to the server!")
        self.isOPen = true
        do {
            try xs?.authenticateWithPassword(pwd)
        } catch {
            fatalError("密码错误")
        }
    }
    
    //验证成功
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        //上线
        goOnline()
    }
    
    
    
    
    //发送上线状态
    func goOnline() {
        let p = XMPPPresence()
        xs!.sendElement(p)
    }
    //发送下线状态
    func goOffline() {
        let p = XMPPPresence(type: "unavailable")
        xs!.sendElement(p)
    }
    
    
    
    
    
    //登入
    func connect() -> Bool {
        //建立通道
        buildStream()
        
        let weixinID = NSUserDefaults.standardUserDefaults().stringForKey("weixinID")
        let password = NSUserDefaults.standardUserDefaults().stringForKey("weixinPwd")
        let server = NSUserDefaults.standardUserDefaults().stringForKey("wxserver")
        
        
        //如果通道已经连接,直接返回连接成功
        if xs!.isConnected() {
            return true
        }
        
        //如果用户名和密码不为空
        if (weixinID != nil && password != nil) {
            
            xs!.myJID = XMPPJID.jidWithString(weixinID!)
            pwd = password!
            xs!.hostName = server!
            
            print("\(xs!.myJID) \(pwd) \(xs!.hostName)")
            
            do {
                try xs?.connectWithTimeout(5000)
            } catch {
                fatalError("密码错误")
            }
        }
        
        return false
    }
    
    //登出
    func disConnect() {
        if self.xs != nil {
            if xs!.isConnected() {
                goOffline()
                xs?.disconnect()
            }
        }
    }
    
    
    
    
    
    //在线状态
    func xmppStream(sender: XMPPStream!, didReceivePresence presence: XMPPPresence!) {
        //我自己的用户名
        let myUser = sender.myJID.user
        //好友的用户名
        let user = presence.from().user
        //好友所在的域
        let domain = presence.from().domain
        //状态类型
        let pType = presence.type()
        //如果状态不是自己的
        if (user != myUser) {
            //状态保存的结构
            var zt = ZhuangTai()
            //保存了状态的完整用户名
            zt.name = user + "@" + domain
            //上线
            if pType == "available" {
                zt.isOnline = true
                ztdl?.isOn(zt)
            }else if pType == "unavailable" {
                ztdl?.isOff(zt)
            }
        }
        
    }
    
    
    
    //收到消息
    func xmppStream(sender: XMPPStream!, didSendMessage message: XMPPMessage!) {
        
        print(message)
        
        //如果是聊天消息
        if message.isChatMessage() {
            var msg = WXMessage()
            //对消息内容进行判断 对方正在输入
            if message.elementForName("composing") != nil {
                msg.isComposing = true
            }
            //离线消息
            if message.elementForName("delay") != nil {
                msg.isDelay = true
            }
            //消息正文
            if let body = message.elementForName("body") {
                msg.body = body.stringValue()
            }
            //完整用户名
            msg.from = message.from().user + "@" + message.from().domain
            
            //加入消息代理中
            xxdl?.newMsg(msg)
        }
    }
    
    
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let navigationVC = UINavigationController(rootViewController: BuddyListTableViewController());
        self.window?.rootViewController = navigationVC;
        self.window?.makeKeyAndVisible();
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

