//
//  AlertViewController.swift
//  SportTime
//
//  Created by Alex on 15.12.2020.
//

import UIKit
//import CoreData

//protocol AlertViewControllerDelegate: class {
//    func getData(nameExersise: String, timeExersise: String, timeRelax: String, descriptionExersise: String, indexCell: Int?)
//    func closAlert()
//}

class AlertViewController: UIView {
    
  //  weak var myDelegate: AlertViewControllerDelegate!
    
   // var exercise: Exercises!
    
    var arr24 = [Int]()
    var arr60 = [Int]()
    var labelTimeEx = UILabel()
    var labelTimeRelax = UILabel()
    
    var labelTextEx = UILabel()
    var labelTextRelax = UILabel()
    
    var textFieldName = UITextField()
    var textViewDescription = UITextView()
    var tags = Int()
    var indexCell: Int?
  //  var textInField = ""
    let pickerControl = UIPickerView()
    var activePicker = Bool()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    //MARK: - create Picker View
    func createPickerView() {
        let y = labelTimeRelax.frame.origin.y + labelTimeRelax.frame.height
        let x = textFieldName.frame.origin.x
        
        let pickerHeight = self.frame.height - (self.frame.height / 2) - 150
        pickerControl.frame = CGRect(x: x, y: y + 10 , width: self.frame.width - x * 2, height: pickerHeight)
        pickerControl.dataSource = self
        pickerControl.delegate = self
        pickerControl.backgroundColor = .yellow
        pickerControl.layer.borderWidth = 1
        pickerControl.layer.borderColor = UIColor.black.cgColor
        pickerControl.layer.cornerRadius = pickerControl.bounds.width / 20
        if activePicker == false {
            pickerControl.isUserInteractionEnabled = false
        } else {
            pickerControl.isUserInteractionEnabled = true
        }
        addSubview(pickerControl)
    }
    
    func addNumberInArry() {
        for i in 0...30 {
            arr24.append(i)
        }
        for y in 0...60 {
            arr60.append(y)
        }
    }
    
    //MARK: - create All Elements
    func createAllElements() {
        let x: CGFloat = 10
        let widthLabel = (self.frame.width - (x * 3)) / 2
        let widthTextLable = widthLabel * 1.5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(gesture1))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(gesture2))
        
        textFieldName.frame = CGRect(x: x, y: 50, width: self.frame.width - x * 2, height: self.frame.height / 12)
        textFieldName.font = UIFont.systemFont(ofSize: 40)
        textFieldName.textAlignment = .center
        textFieldName.layer.cornerRadius = textFieldName.bounds.width / 30
        textFieldName.backgroundColor = .white
        textFieldName.placeholder = "Exercise name"
        
        labelTextEx.frame = CGRect(x: x, y: textFieldName.frame.origin.y + textFieldName.frame.height + x , width: widthTextLable, height: self.frame.height / 12)
        labelTextEx.text = "time exersice"
        labelTextEx.font = UIFont.systemFont(ofSize: 20)
        labelTextEx.textAlignment = .center
        labelTextEx.layer.masksToBounds = true
        labelTextEx.layer.cornerRadius = labelTextEx.bounds.width / 20
        labelTextEx.backgroundColor = .white
        labelTextEx.isUserInteractionEnabled = false
        
        labelTimeEx.frame = CGRect(x: x + labelTextEx.frame.width + x , y: labelTextEx.frame.origin.y, width: textFieldName.frame.width - labelTextEx.frame.width - x, height: self.frame.height / 12)
        labelTimeEx.text = "ex 0:0"
        labelTimeEx.font = UIFont.systemFont(ofSize: 20)
        labelTimeEx.textAlignment = .center
        labelTimeEx.layer.masksToBounds = true
        labelTimeEx.layer.cornerRadius = labelTimeEx.bounds.width / 7
       // labelTimeEx.layer.borderWidth = 1
       // labelTimeEx.layer.borderColor = UIColor.black.cgColor
        labelTimeEx.backgroundColor = .white
        labelTimeEx.isUserInteractionEnabled = true
        labelTimeEx.addGestureRecognizer(tap)
        labelTimeEx.tag = 1
        

        labelTextRelax.frame = CGRect(x: x, y: labelTextEx.frame.origin.y + labelTextEx.frame.height + x , width: widthTextLable, height: self.frame.height / 12)
        labelTextRelax.text = "time relax"
        labelTextRelax.font = UIFont.systemFont(ofSize: 20)
        labelTextRelax.textAlignment = .center
        labelTextRelax.layer.masksToBounds = true
        labelTextRelax.layer.cornerRadius = labelTextRelax.bounds.width / 20
       // labelTextRelax.layer.borderWidth = 1
       // labelTextRelax.layer.borderColor = UIColor.black.cgColor
        labelTextRelax.backgroundColor = .white
        labelTextRelax.isUserInteractionEnabled = false
        
        
        labelTimeRelax.frame = CGRect(x: x + labelTextRelax.frame.width + x , y: labelTextRelax.frame.origin.y, width: textFieldName.frame.width - labelTextRelax.frame.width - x, height: self.frame.height / 12)
        labelTimeRelax.text = "rel 0:0"
        labelTimeRelax.font = UIFont.systemFont(ofSize: 20)
        labelTimeRelax.textAlignment = .center
        labelTimeRelax.layer.masksToBounds = true
        labelTimeRelax.layer.cornerRadius = labelTimeRelax.bounds.width / 7
       // labelTimeRelax.layer.borderWidth = 1
       // labelTimeRelax.layer.borderColor = UIColor.black.cgColor
        labelTimeRelax.backgroundColor = .white
        labelTimeRelax.isUserInteractionEnabled = true
        labelTimeRelax.addGestureRecognizer(tap2)
        labelTimeRelax.tag = 2
        
        
        
        addSubview(textFieldName)
        addSubview(labelTextEx)
        addSubview(labelTextRelax)
        
        addSubview(labelTimeRelax)
        addSubview(labelTimeEx)
    }
    //MARK: - create text Field Description
    func createtextFieldDescription() {
        let x = pickerControl.frame.origin.x
        let textFieldDescriptionY = pickerControl.frame.origin.y + pickerControl.frame.height + x
        textViewDescription.frame = CGRect(x: x, y: textFieldDescriptionY, width: self.frame.width - x * 2, height: (self.frame.height - textFieldDescriptionY - x) / 2)
        textViewDescription.layer.borderWidth = 1
        textViewDescription.layer.borderColor = UIColor.black.cgColor
        textViewDescription.backgroundColor = .white
        textViewDescription.textContainer.maximumNumberOfLines = 20
        textViewDescription.font = .systemFont(ofSize: 21.0)
        textViewDescription.textContainer.lineBreakMode = .byWordWrapping
        textViewDescription.layer.cornerRadius = textViewDescription.bounds.width / 30
        textViewDescription.delegate = self
        textViewDescription.text = "Enter a description for the exercise"
        textViewDescription.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        // labelTimeRelax.isUserInteractionEnabled = true
        addSubview(textViewDescription)
        print("textViewDescription.text ====  \(textViewDescription.text)")
    }
    
    
    @objc func gesture1() {
        tags = 1
        pickerControl.isUserInteractionEnabled = true
        labelTimeEx.backgroundColor = UIColor.white
        labelTimeRelax.backgroundColor = .lightGray
        resetPicker()
        print(tags)
    }
    
    @objc func gesture2() {
        tags = 2
        pickerControl.isUserInteractionEnabled = true
        labelTimeRelax.backgroundColor = UIColor.white
        labelTimeEx.backgroundColor = .lightGray
        resetPicker()
        print(tags)
    }
    
    func resetPicker() {
        pickerControl.selectRow(0, inComponent: 0, animated: true)
        pickerControl.selectRow(0, inComponent: 1, animated: true)
        pickerControl.reloadAllComponents()
        pickerControl.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - create Buttons
    func createButtons() {
        let x = 10
        let y = 10
        let widthButton = 55
        let heightButton = 25
        let cancleButt = UIButton(frame: CGRect(x: x, y: Int(y), width: widthButton, height: heightButton))
        cancleButt.layer.cornerRadius = cancleButt.bounds.height / 3
        cancleButt.setTitle("Back", for: .normal)
        cancleButt.backgroundColor = .red
        cancleButt.setTitleColor(.black, for: .normal)
        cancleButt.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        
        
        let okButton = UIButton(frame: CGRect(x: Int(self.frame.width) - widthButton - x , y: y, width: widthButton, height: heightButton))
        okButton.layer.cornerRadius = okButton.bounds.height / 3
        okButton.setTitle("Save", for: .normal)
        okButton.backgroundColor = .green
        okButton.setTitleColor(.black, for: .normal)
        okButton.addTarget(self, action: #selector(saveDataAlert), for: .touchUpInside)
        
        addSubview(okButton)
        addSubview(cancleButt)
    }
    
    @objc func closeAlert() {
    //    myDelegate.closAlert()
        //self.removeFromSuperview()
    }
    
    @objc func saveDataAlert() {
   //     myDelegate.getData(nameExersise: textFieldName.text!, timeExersise: labelTimeEx.text!, timeRelax: labelTimeRelax.text!, descriptionExersise: textViewDescription.text!, indexCell: indexCell)
   //     closeAlert()
        //  print("indexCell in Allert = \(indexCell)")
        print("saveDataAlert()")
    }
    //MARK: - upDown View For Keyboard
    func upDownViewForKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.frame.origin.y = -50
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            print("(upDownViewForKeyboard)  ----  down")
            self.textViewDescription.backgroundColor = .lightGray
            self.frame.origin.y = 150
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textFieldName.resignFirstResponder()
        self.textViewDescription.resignFirstResponder()
    }
    
    deinit {
        print("deinit AlertViewController")
    }
    
}

//MARK: - Picker View 
extension AlertViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return arr24.count
        case 1 :
            return arr60.count
        default:
            return 5
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(arr24[row]) + " " + "min."
        case 1:
            return String(arr60[row]) + " " + "sec."
        default:
            return "error"
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        
        switch component {
        case 0:
            attributedString = NSAttributedString(string: String(arr24[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        case 1:
            attributedString = NSAttributedString(string: String(arr60[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            
        default:
            attributedString = nil
        }
        
        return attributedString
    }
    
    
    
    //MARK - pickerView не сбрасываеться. Нужно разобраться.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var attributedString: NSAttributedString!
        
        let rowComponent0 = pickerView.selectedRow(inComponent: 0)
        let rowComponent1 = pickerView.selectedRow(inComponent: 1)
        
        let textM = arr24[rowComponent0]
        let textS = arr60[rowComponent1]
        
        if tags == 1 {
            labelTimeEx.text = "\(textM):\(textS)"
            resetPicker()
            pickerView.reloadAllComponents()
            pickerView.resignFirstResponder()
        } else if tags == 2 {
            
            labelTimeRelax.text = "\(textM):\(textS)"
            resetPicker()
            pickerView.reloadAllComponents()
            pickerView.resignFirstResponder()
        }
    }
}

extension AlertViewController: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter a description for the exercise" {
            textViewDescription.text = ""
            textViewDescription.textColor = UIColor.black
        } else if textView.text != "" {
            textView.text = textViewDescription.text
            textViewDescription.textColor = UIColor.black
        }
        textView.becomeFirstResponder()
    }

    public func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {
            textViewDescription.text = "Enter a description for the exercise"
            textViewDescription.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        }
        textView.resignFirstResponder()
    }
}
