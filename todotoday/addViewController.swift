//
//  addViewController.swift
//  todotoday
//
//  Created by 田中千洋 on 2016/05/31.
//  Copyright © 2016年 田中 颯. All rights reserved.
//

import UIKit

class addViewController: UIViewController , UITextFieldDelegate, UIPickerViewDelegate{

    let terra = NSUserDefaults.standardUserDefaults()
    var task:[String:AnyObject] = [:]
    var myTextField: UITextField!
    var Inputnumber:Int  = 3
    var Inputnumber2:Int = 3
    var myButton: UIButton!
    // var dateTextField: UITextField!
    
    
    var datetextField: UITextField!
    var toolBar:UIToolbar!
    var myDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
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
        
        let improtantSlider = UISlider(frame: CGRectMake(0, 0, 200, 30))
        improtantSlider.layer.position = CGPointMake(self.view.frame.midX, 500)
        improtantSlider.backgroundColor = UIColor.whiteColor()
        improtantSlider.layer.cornerRadius = 10.0
        improtantSlider.layer.shadowOpacity = 0.5
        improtantSlider.layer.masksToBounds = false
        improtantSlider.tag = 1
        
        // 最小値と最大値を設定する.
        improtantSlider.minimumValue = 1
        improtantSlider.maximumValue = 5
        
        // Sliderの位置を設定する.
        improtantSlider.value = 1
        
        // Sliderの現在位置より右のTintカラーを変える.
        improtantSlider.maximumTrackTintColor = UIColor.grayColor()
        
        // Sliderの現在位置より左のTintカラーを変える.
        improtantSlider.minimumTrackTintColor = UIColor.blackColor()
        
        improtantSlider.addTarget(self, action: "onChangeValueMySlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(improtantSlider)
        
        
        myButton = UIButton()
        
        // サイズを設定する.
        myButton.frame = CGRectMake(0,0,200,40)
        
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.redColor()
        
        // 枠を丸くする.
        myButton.layer.masksToBounds = true
        
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:150)
        
        // タグを設定する.
        
        
        // イベントを追加する.
        myButton.addTarget(self, action: "myButton:", forControlEvents: .TouchUpInside)
        
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)


        myDatePicker = UIDatePicker()
        
        // datePickerを設定（デフォルトでは位置は画面上部）する.
        myDatePicker.frame = CGRectMake(0, 200, self.view.frame.width, 250)
        myDatePicker.timeZone = NSTimeZone.localTimeZone()
        myDatePicker.backgroundColor = UIColor.whiteColor()
        myDatePicker.layer.cornerRadius = 5.0
        myDatePicker.layer.shadowOpacity = 0.5
        
        // 値が変わった際のイベントを登録する.
        myDatePicker.addTarget(self, action: "onDidChangeDate:", forControlEvents: .ValueChanged)
        
        // DataPickerをViewに追加する.
        // self.view.addSubview(myDatePicker)
        
        // UITextFieldを作成する.
//        dateTextField = UITextField(frame: CGRectMake(0,0,200,30))
//        dateTextField.text = ""
//        dateTextField.borderStyle = UITextBorderStyle.RoundedRect
//        dateTextField.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height - 100);
//        
//        // UITextFieldをViewに追加する.
//        self.view.addSubview(dateTextField)
//        
        
        
        
        
        datetextField = UITextField(frame: CGRectMake(self.view.frame.size.width/3, 100, 0, 0))
        datetextField.delegate = self
        datetextField.layer.position = CGPoint(x:100,y:200)
        datetextField.placeholder = dateToString(NSDate())
        datetextField.text        = dateToString(NSDate())
        datetextField.sizeToFit()
        datetextField.borderStyle = UITextBorderStyle.RoundedRect
        datetextField.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(datetextField)
        
        
        
        
        // UIDatePickerの設定
        myDatePicker = UIDatePicker()
        myDatePicker.addTarget(self, action: "changedDateEvent:", forControlEvents: UIControlEvents.ValueChanged)
        myDatePicker.datePickerMode = UIDatePickerMode.Date
        datetextField.inputView = myDatePicker
        
        // UIToolBarの設定
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height - 20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .Bordered, target: self, action: "tappedToolBarBtn:")
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: .Bordered, target: self, action: "tappedToolBarBtnToday:")
        
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn, toolBarBtnToday]
        
        datetextField.inputAccessoryView = toolBar
        
        
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
    func myButton(sender:UIButton) {
        
        // var udId : [Dictionary<String,AnyObject>] = terra.objectForKey("array") as! [Dictionary<String,AnyObject>]
       //  task = (["name":myTextField.text!,"num":Inputnumber])
        
        var name:String = myTextField.text!
        var num:Int = Inputnumber
        let myDateFormatter: NSDateFormatter = NSDateFormatter()
        myDateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        var duedate:NSDate = myDatePicker.date

              
        self.createtask(todo: name, date: duedate, importances: num)
        
       
        
        let mysecondViewController: UIViewController = ViewController()
        self.navigationController?.pushViewController(mysecondViewController, animated: true)

    }
    func createtask(todo content: String, date: NSDate,importances: Int) {
        // それぞれのUITextFieldに入っているデータを元に、保存するデータを作成
        let todo = taskModel.create(content,duedate: date,importance: importances)
        // 作成したデータを保存
        todo.save()
        print("create")
    }
//    internal func onDidChangeDate(sender: UIDatePicker){
//        
//        // フォーマットを生成.
//        let myDateFormatter: NSDateFormatter = NSDateFormatter()
//        myDateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
//        
//        // 日付をフォーマットに則って取得.
//        let mySelectedDate: NSString = myDateFormatter.stringFromDate(sender.date)
//        dateTextField.text = mySelectedDate as String
//    }
//    
    
    
    
    
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        datetextField.resignFirstResponder()
    }
    
    // 「今日」を押すと今日の日付をセットする
    func tappedToolBarBtnToday(sender: UIBarButtonItem) {
        myDatePicker.date = NSDate()
        changeLabelDate(NSDate())
    }
    
    //
    func changedDateEvent(sender:AnyObject?){
        var dateSelecter: UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(myDatePicker.date)
    }
    
    func changeLabelDate(date:NSDate) {
        datetextField.text = self.dateToString(date)
    }
    
    func dateToString(date:NSDate) ->String {
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let comps: NSDateComponents = calender.components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Day,NSCalendarUnit.Hour,NSCalendarUnit.Minute,NSCalendarUnit.Second,NSCalendarUnit.Weekday], fromDate: date)
        
        var date_formatter: NSDateFormatter = NSDateFormatter()
        var weekdays: Array  = ["日", "月", "火", "水", "木", "金", "土"]
        
        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyyy年MM月dd日（\(weekdays[comps.weekday])） "
        
        return date_formatter.stringFromDate(date)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //非表示にする。
        if(datetextField.isFirstResponder()){
            datetextField.resignFirstResponder()
        }
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