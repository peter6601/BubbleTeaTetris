//
//  SettingViewController.swift
//  TetrisSpecial
//
//  Created by 丁暐哲 on 2016/11/14.
//  Copyright © 2016年 Din. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var teaTypePicker: UIPickerView!{
        didSet{
            teaTypePicker.delegate = self
            teaTypePicker.dataSource = self
        }
    }
    
    @IBAction func particleSlider(_ sender: UISlider) {
        partical = Int(sender.value)
        
    }
    @IBAction func gravitySwitch(_ sender: UISwitch) {
       switcher = sender.isOn
    }
    
    
    var teaType = ["珍珠奶茶","仙草凍奶茶","仙人掌奶綠","珍珠奶綠"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teaType[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teaType.count
    }
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("pickerView = \(teaType[row])")
        switch teaType[row] {
        case "珍珠奶茶": GrassJelly = false; bubbleTea = true

        case "仙草凍奶茶": GrassJelly = true; bubbleTea = true

        case "珍珠奶綠" : GrassJelly = false; bubbleTea = false
            default: break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
