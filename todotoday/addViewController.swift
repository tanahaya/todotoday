//
//  addViewController.swift
//  todotoday
//
//  Created by 田中千洋 on 2016/05/31.
//  Copyright © 2016年 田中 颯. All rights reserved.
//

import UIKit

class addViewController: UIViewController , UITextFieldDelegate {

    var task:[(name:String,num:Int)]!
    var myTextField: UITextField!
    var Inputnumber:Int!
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        task = appDelegate.task
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        self.title = "TASK"
        
        // UITextFieldを作成する.
        myTextField = UITextField(frame: CGRectMake(0,0,200,30))
        
        // 表示する文字を代入する.
        myTextField.text = "Hello Swift!!"
        
        // Delegateを設定する.
        myTextField.delegate = self
        
        // 枠を表示する.
        myTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        // UITextFieldの表示する位置を設定する.
        myTextField.layer.position = CGPoint(x:self.view.bounds.width/2,y:100);
        
        // Viewに追加する.
        self.view.addSubview(myTextField)
        
        let myGreenSlider = UISlider(frame: CGRectMake(0, 0, 200, 30))
        myGreenSlider.layer.position = CGPointMake(self.view.frame.midX, 500)
        myGreenSlider.backgroundColor = UIColor.whiteColor()
        myGreenSlider.layer.cornerRadius = 10.0
        myGreenSlider.layer.shadowOpacity = 0.5
        myGreenSlider.layer.masksToBounds = false
        
        // 最小値と最大値を設定する.
        myGreenSlider.minimumValue = 1
        myGreenSlider.maximumValue = 5
        
        // Sliderの位置を設定する.
        myGreenSlider.value = 1
        
        // Sliderの現在位置より右のTintカラーを変える.
        myGreenSlider.maximumTrackTintColor = UIColor.grayColor()
        
        // Sliderの現在位置より左のTintカラーを変える.
        myGreenSlider.minimumTrackTintColor = UIColor.blackColor()
        
        myGreenSlider.addTarget(self, action: "onChangeValueMySlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(myGreenSlider)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    /*
     UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
     */
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        
        return true
    }
    
    /*
     改行ボタンが押された際に呼ばれるデリゲートメソッド.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    func onChangeValueMySlider(sender : UISlider){
        
        
        print(Int(sender.value))
        Inputnumber = Int(sender.value)
        
    }
    func move(sender:UIBarButtonItem){
        
        // task.append(name: myTextField.text , num: "\(Inputnumber)" )
        
        
        
        let mysecondViewController: UIViewController = ViewController()
        self.navigationController?.pushViewController(mysecondViewController, animated: true)
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
