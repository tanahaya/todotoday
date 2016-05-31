//
//  ViewController.swift
//  todotoday
//
//  Created by 田中千洋 on 2016/05/31.
//  Copyright © 2016年 田中 颯. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   // var myItemname: NSMutableArray = ["test1"]
    
    var task:[(name:String,num:Int)] = [(name:"Tamada", num:1),(name:"tanaka",num:2),(name:"tanaka2",num:3),(name:"tanaka3",num:4),(name:"tanaka5",num:5)]
    var myTableView: UITableView!
    var InputStr:String!
    var addBtn: UIBarButtonItem!
    var moveBtn :UIBarButtonItem!
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        task = appDelegate.task
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addCell:")
        
        moveBtn = UIBarButtonItem(title: "移動", style: .Plain, target: self, action: "move:")
        
        // ナビゲーションバーに表示するタイトル.
        self.title = "TODO TODAY"
        
        // ナビゲーションバーを取得.
        self.navigationController?.navigationBar
        
        // ナビゲーションバーを表示.
        self.navigationController?.navigationBarHidden = false
        
        // ナビゲーションバーの右側に編集ボタンを追加.
//        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.rightBarButtonItem = self.addBtn
        self.navigationItem.leftBarButtonItem = self.moveBtn
        
        // Status Barの高さを取得.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Viewの高さと幅を取得.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成( status barの高さ分ずらして表示 ).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cellの登録.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定.
        myTableView.dataSource = self
        
        // Delegateを設定.
        myTableView.delegate = self
        
        // 罫線を青色に設定.
        myTableView.separatorColor = UIColor.blueColor()
        
        // 編集中のセル選択を許可.
        myTableView.allowsSelectionDuringEditing = true
        
        // TableViewをViewに追加する.
        self.view.addSubview(myTableView)
        
    }
    /*
     Cellが選択された際に呼び出される.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // 選択中のセルが何番目か.
        print("Num: \(indexPath.row)")
        
        // 選択中のセルのvalue.
        print("Value: \(task[indexPath.row].num)")
        
        // 選択中のセルを編集できるか.
        print("Edeintg: \(tableView.editing)")
    }
    
    
    /*
     Cellの総数を返す
     (実装必須)
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    /*
     Cellに値を設定する
     (実装必須)
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Cellに値を設定.
        cell.textLabel?.text = "\(task[indexPath.row].name ))"
        
        
        // 背景色
        if task[indexPath.row].num == 1 {
            cell.backgroundColor = UIColor.blueColor()
        }else if task[indexPath.row].num == 2 {
            cell.backgroundColor = UIColor.orangeColor()
        }else if task[indexPath.row].num == 3 {
            cell.backgroundColor = UIColor.greenColor()
        }else if task[indexPath.row].num == 4 {
            cell.backgroundColor = UIColor.whiteColor()
        }else if task[indexPath.row].num == 5 {
            cell.backgroundColor = UIColor.yellowColor()
        }
        
        // 選択された時の背景色
        var cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor.redColor()
        cell.selectedBackgroundView = cellSelectedBgView
        return cell
    }
    
    /*
     編集ボタンが押された際に呼び出される
     */
    override func setEditing(editing: Bool, animated: Bool) {
        self.addCell(self)
        
    }
    
    /*
     addButtonが押された際呼び出される
     */
    func addCell(sender: AnyObject) {
        print("追加")
        let myAlert: UIAlertController = UIAlertController(title: "Todo", message: "入力してください", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        // OKアクション生成.
        let OkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            print("OK")
            
            // self.myItemname.addObject(self.InputStr)
            self.myTableView.reloadData()
            
        }
        
        // Cancelアクション生成.
        let CancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive) { (action: UIAlertAction!) -> Void in
            print("Cancel")
        }
        
        // AlertにTextFieldを追加.
        myAlert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            
            // NotificationCenterを生成.
            let myNotificationCenter = NSNotificationCenter.defaultCenter()
            
            // textFieldに変更があればchangeTextFieldメソッドに通知.
            myNotificationCenter.addObserver(self, selector: "changeTextField:", name: UITextFieldTextDidChangeNotification, object: nil)
        }
        
        
        // Alertにアクションを追加.
        myAlert.addAction(OkAction)
        myAlert.addAction(CancelAction)
        
        // Alertを発動する.
        presentViewController(myAlert, animated: true, completion: nil)
        
        // myItemsに追加.
        //        myItems.addObject("add Cell")
        
        // TableViewを再読み込み.
        
    }
    
    /*
     Cellを挿入または削除しようとした際に呼び出される
     */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // 削除のとき.
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print("削除")
            
            // 指定されたセルのオブジェクトをmyItemsから削除する.
            
            task.removeAtIndex(indexPath.row)
           
            
            // TableViewを再読み込み.
            myTableView.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func changeTextField (sender: NSNotification) {
        
        var textField = sender.object as! UITextField
        
        // 入力された文字を取得.
        InputStr = textField.text
        
        
        
        // 入力された文字が6文字を超えたら入力を制限.
    }
    func move(sender:UIBarButtonItem){
        let mysecondViewController: UIViewController = addViewController()
        self.navigationController?.pushViewController(mysecondViewController, animated: true)
    }
    
}

