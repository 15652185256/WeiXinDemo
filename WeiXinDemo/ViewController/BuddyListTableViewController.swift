//
//  BuddyListTableViewController.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/17.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class BuddyListTableViewController: UITableViewController {
    //好友数组 数据源
    var bList = [WXMessage]()
    
    

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
        
        //注册
        let leftButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "", ImageName: "", bgImageName: "", Target: self, Method: #selector(BuddyListTableViewController.leftButtonClick))
        let item1 = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = item1
        
        //登陆
        let rightButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "登陆", ImageName: "", bgImageName: "", Target: self, Method: #selector(BuddyListTableViewController.rightButtonClick))
        let item2 = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = item2
    }
    
    
    func leftButtonClick() {
        
    }
    
    //登陆
    func rightButtonClick() {
        let vc:LoginViewController = LoginViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    //创建页面
    func createView() {
        
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
