//
//  ChatTableViewController.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/17.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController, UITextFieldDelegate {

    var msgTextFeild:UITextField!//内容输入框
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.createNav()
        
        self.prepareView()
    }
    
    //设置导航
    func createNav() {
        
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = true
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        self.navigationItem.title = "聊天";
        
        //设置导航背景图
        self.navigationController?.navigationBar.barTintColor = RGBA (86.0, g:173.0, b: 216.0, a: 1)
        
        //返回按钮
        let returnButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "< 返回", ImageName: "", bgImageName: "", Target: self, Method: #selector(ChatTableViewController.returnButtonClick))
        let item1 = UIBarButtonItem(customView: returnButton)
        self.navigationItem.leftBarButtonItem = item1
        
        //发送
        let rightButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "发送", ImageName: "", bgImageName: "", Target: self, Method: #selector(ChatTableViewController.rightButtonClick))
        let item2 = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = item2
    }
    
    
    //返回
    func returnButtonClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //发送
    func rightButtonClick() {
        
    }
    
    //设置页面
    func prepareView() {

        let bgView = createView(CGRect(x: 0, y: 0, width: WIDTH, height: 50))
        bgView.backgroundColor = UIColor.grayColor()
        self.tableView.tableHeaderView = bgView
        
        
        //服务器
        self.msgTextFeild = createTextField(CGRect(x:15, y: (50-36)/2,width:WIDTH-30, height:36), placeholder: "请输入内容", passWord: false, Font: 14)
        bgView.addSubview(self.msgTextFeild)
        self.msgTextFeild.delegate = self
        

        //收起键盘
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatTableViewController.tapRootAction)))
        
        //增加监听，当键盘出现或改变时收出消息
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatTableViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        //增加监听，当键退出时收出消息
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatTableViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    
    
    //输入完毕
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //收起键盘
        self.tapRootAction()
        return true
    }
    
    //当键盘出现时调用
    func keyboardWillShow(aNotification:NSNotification) {
        //第一个参数写输入view的父view即可，第二个写监听获得的notification，第三个写希望高于键盘的高度(只在被键盘遮挡时才启用,如控件未被遮挡,则无变化)
        //如果想不通输入view获得不同高度，可自己在此方法里分别判断区别
        CDPMonitorKeyboard.defaultMonitorKeyboard().keyboardWillShowWithSuperView(self.view, andNotification: aNotification, higherThanKeyboard: 0, contentOffsety: 0)
    }
    
    //当键退出时调用
    func keyboardWillHide(aNotification:NSNotification) {
        CDPMonitorKeyboard .defaultMonitorKeyboard().keyboardWillHide()
    }
    
    //页面消息时
    override func viewDidDisappear(animated: Bool) {
        //移除监听，当键盘出现或改变时收出消息
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        //移除监听，当键退出时收出消息
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //收起键盘
    func tapRootAction() {
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
