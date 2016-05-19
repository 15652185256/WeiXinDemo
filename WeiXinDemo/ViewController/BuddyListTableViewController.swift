//
//  BuddyListTableViewController.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/17.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class BuddyListTableViewController: UITableViewController, ZhuangTaiDelegate, XiaoXiDelegate {
    
    //登入
    var leftButton : UIButton!
    //登出
    var rightButton : UIButton!
    
    
    
    //未读消息数组
    var unreadList = [WXMessage]()
    //好友状态数组 数据源
    var ztList = [ZhuangTai]()
    //当前选中好友
    var currentBuddyName = ""
    //是否已经登录
    var logged = false
    
    
    
    
    //获取总代理
    func zdl() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    
    //刷新页面
    override func viewDidAppear(animated: Bool) {
        //取用户名
        let myID = NSUserDefaults.standardUserDefaults().stringForKey("weixinID")
        //取自动登陆
        let autologin = NSUserDefaults.standardUserDefaults().boolForKey("wxautologin")
        
        print(myID,autologin)
        
        //如果配置了用户名和自动登陆。开始登陆
        if (myID != nil && autologin) {
            
            self.leftButtonClick()
            
            self.navigationItem.title = myID! + "的好友"
            //其他情况，则转的登陆页
        } else {
            let navigationVC = UINavigationController(rootViewController: LoginViewController())
            
            self.presentViewController(navigationVC, animated: true, completion: nil)
        }
        //接管消息代理
        zdl().xxdl = self
        //接管状态代理
        zdl().ztdl = self
    }
    
    
    
    //好友上线处理
    func isOn(zt: ZhuangTai) {
        //在列表中查找
        for (index, oldBs) in self.ztList.enumerate() {
            //如果找到,
            if zt.name == oldBs.name {
                //把旧状态从列表中移除
                self.ztList.removeAtIndex(index)
                //退出查找
                break
            }
        }
        //添加状态
        self.ztList.append(zt)
        //刷新表格视图
        self.tableView.reloadData()
    }
    
    //好友离线处理
    func isOff(zt: ZhuangTai) {
        //在列表中查找
        for (index, oldBs) in self.ztList.enumerate()  {
            //如果找到
            if zt.name == oldBs.name {
                //把状态改成下线
                self.ztList[index].isOnline = false
            }
        }
        //刷新表格视图
        self.tableView.reloadData()
    }
    
    //退出登陆
    func meOff() {
        print("退出登陆")
    }
    
    
    
    
    //收到离线或未读消息
    func newMsg(aMsg:WXMessage) {
        //消息正文不为空
        if aMsg.body != "" {
            self.unreadList.append(aMsg)
            self.tableView.reloadData()
        }
    }
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createNav()
        
        self.createView()
    }
    
    //创建头部
    func createNav() {
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = false
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        self.navigationItem.title = "好友列表"
        
        //设置导航背景图
        self.navigationController?.navigationBar.barTintColor = RGBA (86.0, g:173.0, b: 216.0, a: 1)
        
        //登入
        self.leftButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "登入", ImageName: "", bgImageName: "", Target: self, Method: #selector(BuddyListTableViewController.leftButtonClick))
        let item1 = UIBarButtonItem(customView: self.leftButton)
        self.navigationItem.leftBarButtonItem = item1
        
        //登出
        self.rightButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "登出", ImageName: "", bgImageName: "", Target: self, Method: #selector(BuddyListTableViewController.rightButtonClick))
        let item2 = UIBarButtonItem(customView: self.rightButton)
        self.navigationItem.rightBarButtonItem = item2
    }
    
    //登入
    func leftButtonClick() {
        //清空数组 保持容量
        self.unreadList.removeAll(keepCapacity: false)
        self.ztList.removeAll(keepCapacity: false)
        
        //连接服务器
        zdl().connect()
        //我的状态改为在线
        self.logged = true
    }
    
    //登出
    func rightButtonClick() {
        //清空数组 保持容量
        self.unreadList.removeAll(keepCapacity: false)
        self.ztList.removeAll(keepCapacity: false)
        
        //断开服务器
        zdl().disConnect()
        //我的状态改为离线
        logged = false
        
        
        //更新存储
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "wxserver")
        
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "weixinID")
        
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "weixinPwd")
        
        //配置自动登陆
        NSUserDefaults .standardUserDefaults().setBool(false, forKey: "wxautologin")
        
        //同步用户配置
        NSUserDefaults .standardUserDefaults().synchronize()
        
        
        
        //跳转登陆页
        let navigationVC = UINavigationController(rootViewController: LoginViewController())
        
        self.presentViewController(navigationVC, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    //创建页面
    func createView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT-64))
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.ztList.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
        
        //好友在线状态
        let online = self.ztList[indexPath.row].isOnline
        
        //状态文字提示(前缀)
        let onlineTips = online ? "(在线) " : "(离线) "
        
        //好友用户名(正文)
        let buddyName = self.ztList[indexPath.row].name
        
        
        //未读消息条数
        var unread = 0
        
        //在未读消息里查找相应的用户,并计数
        for msg in self.unreadList {
            if buddyName == msg.from {
                unread += 1
            }
        }
        //未读条数提示(后缀)
        let unreadTips = (unread == 0 ? "" : "(\(unread)条未读)")
        
        
        //单元格文本组装: 在线状态 + 正文 + 未读消息条数
        cell.textLabel!.text = onlineTips + buddyName + unreadTips
        
        
        
        //单元格图片提示在线状态
        if online {
            cell.imageView?.image = UIImage(named: "online")
        } else {
            cell.imageView?.image = UIImage(named: "offline")
        }
        
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
