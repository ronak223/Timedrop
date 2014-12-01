//
//  NewTimerModalVC.swift
//  Timedrop
//
//  Created by Ronak Patel on 11/23/14.
//  Copyright (c) 2014 Ronak Patel. All rights reserved.
//

import UIKit

/* accessible app-wide globals
    timerTitlesList:[String]
    timerTotalSecondsList:[Double]
*/

class NewTimerModalVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var timerPicker: UIPickerView!
    @IBOutlet weak var currentChosenTimeLabel: UILabel!
    @IBOutlet weak var timerTitleInput: UITextField!
    
    //class globals for chosen hours, mins, secs
    var hours:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    
    //class constants
    let SECONDS_IN_HOUR:Int = 3600
    let SECONDS_IN_MINUTE:Int = 60
    
    //timerPickerValues. component1=hours[0-23], component2=minutes[0-59], component3=seconds[0-59]
    let timerPickerValues = [
        [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23],
        [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59],
        [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.timerTitleInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    methods for UIPIckerViewDataSource
    */
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return timerPickerValues.count
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return timerPickerValues[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var rowTitle = "\(timerPickerValues[component][row])"
        switch component {
            
            case 0:
                rowTitle += " hr"
            case 1:
                rowTitle += " min"
            case 2:
                rowTitle += " sec"
            default:
                return rowTitle
        }
        
        return rowTitle
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }
    
    func updateLabel(){
        hours = timerPickerValues[0][timerPicker.selectedRowInComponent(0)]
        minutes = timerPickerValues[1][timerPicker.selectedRowInComponent(1)]
        seconds = timerPickerValues[2][timerPicker.selectedRowInComponent(2)]
        
        currentChosenTimeLabel.text = NSString(format: "%02d:%02d:%02d", hours, minutes, seconds)

    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true);
        return false;
    }
    
    @IBAction func addTimerButton(sender: UIButton) {
        if(!timerTitleInput.hasText()){
            timerTitleList.append("")
        }
        else{
            timerTitleList.append(timerTitleInput.text)
        }
        
        //converting chosen time values to just seconds
        var totalSeconds:Double = Double((hours * SECONDS_IN_HOUR) + (minutes * SECONDS_IN_MINUTE) + seconds)
        timerTotalSecondsList.append(totalSeconds)
        
//        //sending notification to parentVC (ViewController) in order to update the table view
//        self.dismissViewControllerAnimated(true, completion: { () -> Void in
//            NSNotificationCenter.defaultCenter().postNotificationName("updateParent", object: nil)
//        })
        
        
    }

    @IBAction func cancelbutton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
