//
//  ViewController.swift
//  KiteNewsSwift
//
//  Created by 邱少藩 on 16/5/12.
//  Copyright © 2016年 邱少藩. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLogin:UIButton!
    @IBOutlet weak var tfAccount:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    
    @IBAction func onLogin(){
        if (tfAccount.text!.isEmpty || tfPassword.text!.isEmpty)
        {
            showNoticeErr("Account or Password can not be empty!")
        }
        else
        {
            queryUserNameAndPassword(tfAccount.text!,ipassword:tfPassword.text!)
        }
        
    }
    @IBAction func onSignUp()
    {
        
        createTableorSave(tfAccount.text!,password: tfPassword.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func createTableorSave(name:String,password:String)
    {
        let kiteNewsUser=BmobObject(className: "kiteNewsUser")
        kiteNewsUser.setObject(name, forKey: "user_name")
        kiteNewsUser.setObject(password, forKey: "user_password")
        kiteNewsUser.saveInBackgroundWithResultBlock{(isSuccessful,error) in
           if error != nil
           {
               print("Fail")
            }
            else
           {
               print("Successful")
            }
        }
        
    }
    
    func queryUserNameAndPassword(iname:String,ipassword:String)
    {
        let query:BmobQuery=BmobQuery(className: "kiteNewsUser")
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock{(array,error) in
           for i in 0..<array.count
           {
            let obj:BmobObject=array[i] as! BmobObject
            let name:String=obj.objectForKey("user_name") as! String
            let password:String=obj.objectForKey("user_password") as! String
               print("object name \(name),password \(password)")
               if name == iname && password == ipassword
               {
                  self.intoMainViewController()
               }
            
            }
        }
    }
    
    func intoMainViewController()
    {
        let myStoryBoard:UIStoryboard!=self.storyboard
        let mainViewController:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("main_view") as UIViewController
        self.presentViewController(mainViewController, animated: true, completion: nil)
        
    }
}

