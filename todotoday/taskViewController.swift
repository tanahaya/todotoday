//
//  taskViewController.swift
//  todotoday
//
//  Created by 田中千洋 on 2016/06/21.
//  Copyright © 2016年 田中 颯. All rights reserved.
//

import UIKit
import RealmSwift

public enum FetchType { // 取得するデータを決めるためのenum
    case All // すべてのToDoを取得するためのenum
    case UnDone // 完了していないToDoを取得するためのenum
}

class taskModel: Object{
    
    static let realm = try! Realm()

    dynamic private var id:Int = 0
    dynamic var name:String = ""//名前
    dynamic var importance: Int = 0//重要度
    dynamic var due_date: NSDate!//期限
    dynamic var isDone:Int = 0//完了なら1まだなら0


    override static func primaryKey() -> String {
        return "id"
    }
    static func create(content:String,duedate:NSDate,importance:Int) -> taskModel {
        let todo = taskModel()
        todo.name  = content
        todo.importance = importance
        todo.due_date = duedate
        todo.isDone = 0
        todo.id = lastId()
        
        return todo
        
        
        
    }
    static func update(model:taskModel,content: String,dueDate:NSDate,importance:Int) {
        try! realm.write({
            model.name = content
            model.due_date = dueDate
            model.isDone = 0
            
        })
    }
    static func fetch(FetchType type: FetchType) -> [taskModel] {
        // .Allなら全件、.UnDoneなら未完了のデータを取得する
        switch type {
        case .All:
            return loadAll()
        case .UnDone:
            return loadUndone()
        }
    }
    static func loadAll() -> [taskModel] {
        // idでソートしながら、全件取得
        let todos = realm.objects(taskModel).sorted("id", ascending: true)
        // 取得したデータを配列にいれる
        var ret: [taskModel] = []
        for todo in todos {
            ret.append(todo)
        }
        return ret
    }
    static func loadUndone() -> [taskModel] {
        // isDoneが0でフィルターをかけて取得
        let todos = realm.objects(taskModel).filter("isDone = 0")
        //取得したデータを配列にいれる
        var ret: [taskModel] = []
        for todo in todos {
            ret.append(todo)
        }
        return ret
    }
    static func lastId() -> Int {
        // isDoneの値を変更するとデータベース上の順序が変わるために、以下のようにしてidでソートして最大値を求めて+1して返す
        // 更新の必要がないなら、 realm.objects(ToDoModel).last で最後のデータのidを取得すればよい
        if let todo = realm.objects(taskModel).sorted("id", ascending: false).first {
            return todo.id + 1
        }else {
            return 1
        }
    }
    
    // ローカルのdefault.realmに作成したデータを保存するメソッド
    func save() {
        // writeでtransactionを生む
        try! taskModel.realm.write {
            // モデルを保存
            taskModel.realm.add(self)
        }
    }
    
    // TODO: UITableViewRowActionからインスタンスを送れない
    func delete(idOfDelete id: Int)  {
        let item = realm?.objects(taskModel)[id]
        try! realm?.write {
            realm?.delete(item!)
        }
    }
    
    func updateDone(idOfUpdate id: Int) {
        let item = realm?.objects(taskModel)[id]
        try! realm?.write {
            item?.isDone = 1
        }
    }
    
    
    
    }

