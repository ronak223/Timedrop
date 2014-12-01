//
//  ViewController.swift
//  Timedrop
//
//  Created by Ronak Patel on 11/21/14.
//  Copyright (c) 2014 Ronak Patel. All rights reserved.
//

import UIKit

//app-wide timer storage lists
var timerTitleList:[String] = []
var timerTotalSecondsList:[Double] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //TODO: timer updates reset on off-screen cells when there are more than screen-heigh amount of cells and scrolling is necessary. problem may be with dequeueReuseableCell

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registering nib for custom timer cells
        var nib = UINib(nibName: "TimerCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "timerCell")
        
        //NSNotification for refreshing tableview from modal view
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTable", name: "updateParent", object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
        UITableViewDataSource required methods
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return timerTotalSecondsList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell:TimerCell = tableView.dequeueReusableCellWithIdentifier("timerCell") as TimerCell
        cell.setTimer(timerTotalSecondsList[indexPath.row])
        cell.setTimerLabel(timerTitleList[indexPath.row])
        
        return cell
    }
    
//    func refreshTable(){
//        self.tableView.reloadData()
//        
//    }


}

