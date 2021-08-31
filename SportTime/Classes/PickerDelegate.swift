//
//  PickerDelegate.swift
//  SportTime
//
//  Created by Alex on 22.05.2021.
//
import UIKit
import Foundation

protocol ProtocolPickerDelegate: class {
    func time(time: String)
  //  func reloadComponents()
    
}

class PickerDelegate: UIPickerView {
    
    weak var myDelegate: ProtocolPickerDelegate!
    var time = String()
    var minets = [Int]()
    var second = [Int]()
    var indexCell = Int()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.dataSource = self
        self.delegate = self
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addNumberInArry() {
        for i in  0...59 {
            minets.append(i)
        }
        for y in 0...59 {
            second.append(y)
        }
    }

    func resetPicker() {
        
            selectRow(0, inComponent: 0, animated: true)
            selectRow(0, inComponent: 1, animated: true)
            reloadAllComponents()
            resignFirstResponder()
        print(" resetPicker in PickerDelegate")
    }
    
   
}

extension PickerDelegate: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return minets.count
        case 1 :
            return second.count
        default:
            return 5
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!

        switch component {
        case 0:
            attributedString = NSAttributedString(string: String(format: "%02d", minets[row]) + " " + "min.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        case 1:
            attributedString = NSAttributedString(string: String(format: "%02d", second[row]) + " " + "sec.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])

        default:
            attributedString = nil
        }

        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var attributedString: NSAttributedString!

        let rowComponent0 = pickerView.selectedRow(inComponent: 0)
        let rowComponent1 = pickerView.selectedRow(inComponent: 1)

        let textM = minets[rowComponent0]
        let textS = second[rowComponent1]

        time = String(format: "%02d", textM) + ":" + String(format: "%02d", textS)
        myDelegate.time(time: time)
    }
    
    
    
}

    

