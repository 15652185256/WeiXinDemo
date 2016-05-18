//
//  LoginViewController.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/17.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, RCAnimatedImagesViewDelegate {

    var ServerTextFeild:UITextField!
    
    var UserNameTextFeild:UITextField!
    
    var PasswordTextFeild:UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        self.createNav()
        
        self.createView()
    }
    
    //设置导航
    func createNav() {
        
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = true
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        self.navigationItem.title = "登陆";
        
        //设置导航背景图
        self.navigationController?.navigationBar.barTintColor = RGBA (86.0, g:173.0, b: 216.0, a: 1)
        
        //返回按钮
        let returnButton = createButton(CGRect(x:0, y:0 ,width:60, height:30), Text: "< 返回", ImageName: "", bgImageName: "", Target: self, Method: #selector(LoginViewController.returnButtonClick))
        let item1 = UIBarButtonItem(customView: returnButton)
        self.navigationItem.leftBarButtonItem = item1
    }
    
    
    //返回
    func returnButtonClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    func createView() {
        
        //背景图
        let bgImageVeiw = RCAnimatedImagesView(frame: CGRect(x:0, y:0 ,width:WIDTH, height:HEIGHT))
        self.view.addSubview(bgImageVeiw)
        bgImageVeiw.delegate = self
        bgImageVeiw.startAnimating()
        
        
        //服务器
        self.ServerTextFeild = createTextField(CGRect(x:20, y:100 ,width:WIDTH-40, height:36), placeholder: "请输入服务器域名", passWord: false, Font: 14)
        self.view.addSubview(self.ServerTextFeild)
        self.ServerTextFeild.delegate = self
        
        
        //用户名
        self.UserNameTextFeild = createTextField(CGRect(x:20, y:CGRectGetMaxY(self.ServerTextFeild.frame)+15 ,width:WIDTH-40, height:36), placeholder: "请输入用户名", passWord: false, Font: 14)
        self.view.addSubview(self.UserNameTextFeild)
        self.UserNameTextFeild.delegate = self
        
        
        //密码
        self.PasswordTextFeild = createTextField(CGRect(x:20, y:CGRectGetMaxY(self.UserNameTextFeild.frame)+15 ,width:WIDTH-40, height:36), placeholder: "请输入密码", passWord: true, Font: 14)
        self.view.addSubview(self.PasswordTextFeild)
        self.PasswordTextFeild.delegate = self
        
        //登录
        let loginButton = createButton(CGRect(x:20, y:CGRectGetMaxY(PasswordTextFeild.frame)+15 ,width:WIDTH-40, height:36), Text: "登录", ImageName: "", bgImageName: "", Target: self, Method: #selector(LoginViewController.loginButtonClick))
        loginButton.backgroundColor = RGBA (86.0, g:173.0, b: 216.0, a: 1)
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        loginButton.layer.masksToBounds = true;
        loginButton.layer.cornerRadius = 5.0;
        self.view.addSubview(loginButton)
        
        
        
        
        
        
        //收起键盘
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.tapRootAction)))
        
        //增加监听，当键盘出现或改变时收出消息
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        //增加监听，当键退出时收出消息
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    //登录
    func loginButtonClick() {
        
        NSUserDefaults.standardUserDefaults().setObject(self.ServerTextFeild.text, forKey: "wxserver")
        
        NSUserDefaults.standardUserDefaults().setObject(self.UserNameTextFeild.text, forKey: "weixinID")
        
        NSUserDefaults.standardUserDefaults().setObject(self.PasswordTextFeild.text, forKey: "weixinPwd")
        
        let vc:ChatTableViewController = ChatTableViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    //RCAnimatedImagesViewDelegate 代理
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named:"\(index+1).jpg")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
