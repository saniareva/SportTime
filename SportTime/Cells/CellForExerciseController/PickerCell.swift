//
//  PickerCell.swift
//  SportTime
//
//  Created by Alex on 20.05.2021.
//

import UIKit


class PickerCell: UITableViewCell {

    let myPicker = PickerDelegate()
    var indexCell = Int()

    override func awakeFromNib() {
        super.awakeFromNib()
    //    print("Picjer in cell = \(indexCell) awakeFromNib")
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    //    print("Picjer in cell = \(indexCell) reuseIdentifier")
        contentView.backgroundColor = UIColor.white
        //myPicker.indexCell = indexCell
        myPicker.backgroundColor = UIColor.white
        contentView.addSubview(myPicker)
        

    }
    
    required init?(coder: NSCoder) {
    //    print("Picjer in cell = \(indexCell) required init")
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("Picjer in cell = \(indexCell) layoutSubviews")
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width

        myPicker.frame = CGRect(x: 5 , y: 2, width: widthcontentView  - 10 , height: heightcontentView - 4)
        myPicker.addNumberInArry()
        
        myPicker.backgroundColor = .gray
        myPicker.layer.borderWidth = 1
        myPicker.layer.borderColor = UIColor.black.cgColor
        myPicker.layer.cornerRadius = myPicker.bounds.width / 20
    //    myPicker.isUserInteractionEnabled = false
       // self.automaticallyUpdatesContentConfiguration = true
       // updatePicre()
        addSubview(myPicker)
    }
    
//    func resetPicker() {
//        
//        myPicker.selectRow(0, inComponent: 0, animated: true)
//        myPicker.selectRow(0, inComponent: 1, animated: true)
//        myPicker.reloadAllComponents()
//        myPicker.resignFirstResponder()
//    }
//    func updatePicre() {
//        if indexCell == 2 {
//            resetPicker()
//            print(" extension PickerDelegate: ExerciseControllerDelegate - 2 - \(indexCell)")
//        } else if indexCell == 3 {
//            resetPicker()
//            print(" extension PickerDelegate: ExerciseControllerDelegate - 3 - \(indexCell)")
//        } else {
//            print(" extension PickerDelegate: ExerciseControllerDelegate - 3 - \(indexCell)")
//        }
//        
//    }
    
}

