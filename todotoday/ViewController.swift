//
//  ViewController.swift
//  todotoday
//
//  Created by 田中千洋 on 2016/05/31.
//  Copyright © 2016年 田中 颯. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var task:[taskModel] = []
    
    let terra = NSUserDefaults.standardUserDefaults()
    var myTableView: UITableView!
    var InputStr:String!
    // var addBtn: UIBarButtonItem!
    var moveBtn :UIBarButtonItem!
    var first:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        terra.registerDefaults(["first":0])
        
        
        
        
        // addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addCell:")
        
        moveBtn = UIBarButtonItem(title: "移動", style: .Plain, target: self, action: "move:")
        
        // ナビゲーションバーに表示するタイトル.
        self.title = "TODO TODAY"
        
        // ナビゲーションバーを取得.
        self.navigationController?.navigationBar
        
        // ナビゲーションバーを表示.
        self.navigationController?.navigationBarHidden = false
        
        // ナビゲーションバーの右側に編集ボタンを追加.
//        self.navigationItem.rightBarButtonItem = self.editButtonItem()
      //   self.navigationItem.rightBarButtonItem = self.addBtn
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
    override func viewWillAppear(animated: Bool) {
        first = terra.integerForKey("first")
        print(first)
        if first == 0 {
            print("first")
            first = 1
            terra.setObject(first, forKey: "first")

        }else {
            first = 0
            terra.setObject(first, forKey: "first")
            print(first)
            
            var num:Int!
            var name:AnyObject!
           
            
            num = terra.integerForKey("newtasknum")
            name = terra.objectForKey("newtaskname")
            print(num)
            print(name)
//            task.append(["name":name,"num":num])
           
            myTableView.reloadData()
            
        }
    }
    /*
     Cellが選択された際に呼び出される.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // 選択中のセルが何番目か.
//        print("Num: \(indexPath.row)")
//        
//        // 選択中のセルのvalue.
//        print("Value: \(task[indexPath.row])")
//        
//        // 選択中のセルを編集できるか.
//        print("Edeintg: \(tableView.editing)")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Cellに値を設定.
//        let item = task[indexPath.row] as! Dictionary<String, AnyObject>
//        
//        cell.textLabel?.text = "\(item["name"] as! String)"
//        if item["num"] as! Int == 1 {
//            cell.backgroundColor = UIColor.blueColor()
//        }else if item["num"] as! Int == 2 {
//            cell.backgroundColor = UIColor.redColor()
//        }else if item["num"] as! Int == 3 {
//            cell.backgroundColor = UIColor.yellowColor()
//        }else if item["num"] as! Int == 4  {
//            cell.backgroundColor = UIColor.greenColor()
//        }else if item["num"] as! Int == 5 {
//            
//        }
//        
//        // 選択された時の背景色
//        var cellSelectedBgView = UIView()
//        cellSelectedBgView.backgroundColor = UIColor.redColor()
//        cell.selectedBackgroundView = cellSelectedBgView
        return cell
    }
    
    /*
     Cellを挿入または削除しようとした際に呼び出される
     */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // 削除のとき.
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print("削除")
            
            // 指定されたセルのオブジェクトをmyItemsから削除する.
            
//             task.removeAtIndex(indexPath.row)
           
            
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

