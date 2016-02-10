//
//  ViewController.swift
//  sampleTeaList
//
//  Created by Eriko Ichinohe on 2016/02/10.
//  Copyright © 2016年 Eriko Ichinohe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var teaListTableView: UITableView!

    var tea_list:[NSDictionary] = []
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        //-- json.txtファイルを読み込んで
        let path = NSBundle.mainBundle().pathForResource("json", ofType: "txt")
        let jsondata = NSData(contentsOfFile: path!)
        //-- 辞書データに変換して
        let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray
        //--  辞書データの個数だけ繰り返して表示する
        for data in jsonArray {
            print("[\(data["name"])]")
            tea_list.append(data as! NSDictionary)
        }
    }

    // 行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tea_list.count
    }
    
    // 表示するセルの中身
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
        //cell.textLabel!.text = "\(indexPath.row)行目"
        
        //文字色を茶色にする
        cell.textLabel?.textColor = UIColor.brownColor()
        //矢印を右側につける
        cell.accessoryType = .DisclosureIndicator
        
        var teaName = tea_list[indexPath.row]["name"] as! String
        
        cell.textLabel!.text = "\(teaName)"
        return cell
        
    }
    
    // 選択された時に行う処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)行目を選択")
        selectedIndex = indexPath.row
        performSegueWithIdentifier("showSecondView",sender: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Segueで画面遷移する時
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var secondVC = segue.destinationViewController as! secondViewController
        
        secondVC.scSelectedIndex = selectedIndex
    }

}

