//
//  ExerciseController.swift
//  SportTime
//
//  Created by Alex on 20.05.2021.
//

import UIKit
import CoreData

protocol ExerciseControllerDelegate {
    func getNumberCell(cell: Int)
}


class ExerciseController: UITableViewController {
    
    var myDelegate: ExerciseControllerDelegate?
    
    var exercise: Exercise!
    
    var nameExercise = String()
    var timeExercise = String()
    var timeRelax = String()
    var descriptionEx = String()
    var myImage =  UIImageView()
    let picker = UIImagePickerController()
    var indexCell = Int()
    
    var chageTime = false
    
    override init(style: UITableView.Style) {
            super.init(style: style)
            // Custom initialization
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented  ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataInCoreData()
       // tableView.scrollToRow(at: <#T##IndexPath#>, at: <#T##UITableView.ScrollPosition#>, animated: <#T##Bool#>)
        tableView.reloadData()

    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createButtons()
            // addimage()
        self.tableView.register(NameCell.self, forCellReuseIdentifier: "NameCell")
        self.tableView.register(TimesExerciseCell.self, forCellReuseIdentifier: "TimesExerciseCell")
        self.tableView.register(TimeRelaxCell.self, forCellReuseIdentifier: "TimeRelaxCell")
        self.tableView.register(PickerCell.self, forCellReuseIdentifier: "PickerCell")
        self.tableView.register(DescriptionCell.self, forCellReuseIdentifier: "DescriptionCell")
        self.tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
   
        
    }

    func createButtons() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(createAlertCamera))
        let backButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItems = [cameraButton, saveButton]
    }
    
    
    @objc func save() {
        createAlertSaveData()
    }
    
    @objc func createAlertCamera() {
        showAlertPhoto()
        print("createCamera")
    }
    
    func addimage() {
        if myImage.image == nil {
            myImage.image = UIImage(named: "unnamed")
        }
    }
    
    
    @objc func close() {
        if exercise.name == nil {
            CoreDataManager.shared.deleteExersis(exercise: exercise)
        }
        navigationController?.popViewController(animated: true)
        print("close")
    }
    
    func getDataInCoreData() {
        if exercise.name == nil {
        } else {
            nameExercise = exercise.name!
        }
        
        if exercise.descriptionEx == nil {
            descriptionEx = "Enter a description for the exercise"
        } else {
            descriptionEx = exercise.descriptionEx!
        }
            timeExercise = exercise.timeExercise ?? "00:00"
            timeRelax = exercise.timeRelax ?? "00:00"
        let imgStr = exercise.img 
        if imgStr == nil {
            myImage.image = UIImage(named: "youtube")
        } else {
            let image = Bace64String().decodingToImage(imageString: imgStr!)
            myImage.image = image
        }
        
        
        
      //  let decodeImg = Bace64String.shared.decodingToImage(imageString: exercise.img!)
       // myImage.image = decodeImg
//        if decodeImg == nil {
//            myImage.image = UIImage(named: "unnamed")
//        } else {
      //      myImage.image = decodeImg
//        }
        print(nameExercise, descriptionEx)
        
    }
   

    func createAlertSaveData() {
        if nameExercise == nil || nameExercise == "" || chageTime == false {
        let allert = UIAlertController(title: "Error", message: "You have not completed all the fields.", preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(allert, animated: true, completion: nil)
        } else {
            tableView.reloadData()
            exercise.name = nameExercise
            exercise.timeRelax = timeRelax
            exercise.timeExercise = timeExercise
            exercise.descriptionEx = descriptionEx
            let encodeStr = Bace64String().encodeToString(image: myImage.image!)
            exercise.img = encodeStr
           // exercise.img = img
            CoreDataManager.shared.saveContext()
            navigationController?.popViewController(animated: true)
            tableView.reloadData()
            tableView.reloadData()
            print("save")
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    deinit {
        print("deinit ExerciseController")
    }
}

extension ExerciseController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            cell.myImage.image = myImage.image //UIImage(named: "unnamed")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell") as! NameCell
            cell.textFieldName.delegate = self
            cell.textFieldName.text = nameExercise
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimesExerciseCell")  as!  TimesExerciseCell
            cell.timeExercise.text = "time"
            
            cell.descriptionTimeExercise.text = timeExercise// exercise.timeExercise
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeRelaxCell")  as!  TimeRelaxCell
            cell.timeRelax.text = "time Relax"
            
            cell.descriptionTimeRelax.text = timeRelax//exercise.timeRelax
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell")  as!  PickerCell
            cell.myPicker.myDelegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell")  as!  DescriptionCell
            cell.textViewDescription.delegate = self
            cell.textViewDescription.text = descriptionEx
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexCell = indexPath.row

        if indexPath.row == 2 || indexPath.row == 3 {
            chageTime = true
        }
        
       
        
            
        
       // myDelegate?.getNumberCell(cell: indexPath.row)
        tableView.reloadData()
        print("cell - \(indexPath.row)")
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 50
        case 2:
            return 50
        case 3:
            return 50
        case 4:
            return 150
        case 5:
            return 180
        default:
            return 50
        }
    }
}

extension ExerciseController: ProtocolPickerDelegate {

    func time(time: String) {
        if indexCell == 2 {
            timeExercise = time
            tableView.reloadData()
        } else if indexCell == 3 {
            timeRelax = time
            tableView.reloadData()
        }
    }
}

extension ExerciseController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameExercise = textField.text!
        //tableView.reloadData()
        
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(textField.text)
//        print("should Change Characters In")
//        //tableView.reloadData()
//        return true
//    }
    
    
}

extension ExerciseController: UITextViewDelegate {

    
    public func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.text == "Enter a description for the exercise" {
            textView.text = ""
            textView.textColor = UIColor.black
        } else if textView.text != "" {
            descriptionEx = textView.text
            textView.textColor = UIColor.black
        }
        textView.becomeFirstResponder()
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            descriptionEx = "Enter a description for the exercise textViewDidEndEditing"
            textView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        } else {
            descriptionEx = textView.text
        }
        textView.resignFirstResponder()
    }
    
    
}

extension ExerciseController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func showAlertPhoto() {

            let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
                self.getImage(fromSourceType: .camera)
            }))
            alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
                 self.getImage(fromSourceType: .photoLibrary)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

            //Check is source type available
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = sourceType
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            self.dismiss(animated: true) { [weak self] in

                guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
                //Setting image to your image view
                self!.myImage.image = image
                self?.tableView.reloadData()
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        myImage.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
//
//        picker.dismiss(animated: true, completion: nil)
//    }
    
}
