//
//  AddViewController.swift
//  SportTime
//
//  Created by Alex on 15.12.2020.
//

import UIKit
import CoreData
import Foundation


class ListExercisesController: UIViewController {
    
    var saveButton = UIBarButtonItem()
    var addButton = UIBarButtonItem()
    
    var tableView = UITableView()
    var nameSetOfExercises = String()

    var indexMyCell: Int?
    let navigationBurHeight = 44

    var exercises: [Exercise] = []
    var listExercises: ListExercises!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        exercises = CoreDataManager.shared.getExercises(for: listExercises)
        isVisibleButton()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        
        
        let backButton = UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(backView))
        
        saveButton = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveBut))
        addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(createNewExercise))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItems = [saveButton, addButton]
        self.view.backgroundColor = .orange
        self.tableView.register(AddTableViewCell.self, forCellReuseIdentifier: "Cell")
        createTable()
    }
    
    @objc func backView() {
        if exercises.isEmpty == true {
            CoreDataManager.shared.deleteListExercises(listExercises: listExercises)
            navigationController?.popViewController(animated: true)
        }
        createAllertCancle()
        
    }
    
    @objc func saveBut() {
        if  exercises.count == 0 {
        }else {
            createAlertSaveData()
        }
    }
    
    func isVisibleButton() {
        if exercises.isEmpty == true {
            saveButton.isEnabled = false
            saveButton.tintColor = UIColor.clear
        } else {
            saveButton.isEnabled = true
            saveButton.tintColor = UIColor.systemBlue
        }
    }
    
    func setTitle() {
        navigationItem.title = listExercises.name ?? ""
    }
    
    
    func chackDataInArr() {
        
        if exercises.isEmpty == true {
        }
        
    }
    
    
    func createTable() {
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    @objc func createNewExercise() {
        let exerciseVC = ExerciseController(style: .plain)
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let exercise = Exercise(context: context)
        listExercises.addToExercise(exercise)
        CoreDataManager.shared.saveContext()
        exerciseVC.exercise = exercise
        navigationController?.pushViewController(exerciseVC, animated: true)
    }
    
    //MARK: - func create Alert standart
    
    func createAlertSaveData() {
        let allert = UIAlertController(title: "The set of exercises", message: "Enter the name of the set of exercises.", preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        allert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [self] (action) in
            let textfield = allert.textFields?.first
            
            if textfield?.text == "" || textfield?.text == nil || textfield?.text == ""{
                let allertError = UIAlertController(title: "Error", message: "Pleace enter the name of the set of exercises.", preferredStyle: .alert)
                allertError.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: { (action) in
                    self.present(allert, animated: true, completion: nil)
                }))
                self.present(allertError, animated: true, completion: nil)
            } else {
                
                //MARK: - Save to List Exercises
                
                self.listExercises.name = textfield?.text
                self.listExercises.countExercises = String(self.exercises.count)
                CoreDataManager.shared.saveContext()
                navigationController?.popViewController(animated: true)
            }
        }))
        allert.addTextField { (textField) in
            textField.text = self.listExercises.name
            
            if textField.text == "" {
                textField.placeholder = "Enter exercise name"
            }
            
        }
        present(allert, animated: true, completion: nil)
    }
    
    func createAllertCancle() {
        let allert = UIAlertController(title: "Do you want to save your changes?", message: "", preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
            CoreDataManager.shared.deleteListExercises(listExercises: self.listExercises)
            self.navigationController?.popViewController(animated: true)
        }))
        
        allert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            self.createAlertSaveData()
        }))
        present(allert, animated: true, completion: nil)
    }
    
    
    deinit {
        print("deinit AddViewController")
    }
}


extension ListExercisesController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idetifireCell = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: idetifireCell, for: indexPath) as! AddTableViewCell
        let exercise = exercises[indexPath.row]
        if cell == nil {
            return  UITableViewCell()
        } else {

        cell.labelName.text = exercise.name
        cell.labelEx.text = exercise.timeExercise
        cell.labelRelax.text = exercise.timeRelax
        cell.descript = exercise.descriptionEx ?? "erro  description exercise"
            let imgStr = exercise.img
            if imgStr == nil {
                cell.images.image = UIImage(named: "youtube")
            } else {
                let image = Bace64String().decodingToImage(imageString: imgStr!)
                cell.images.image = image
            }
            
        return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exerciseVC = ExerciseController(style: .plain)
        exerciseVC.exercise = exercises[indexPath.row]
        navigationController?.pushViewController(exerciseVC, animated: true)
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeEdit = UIContextualAction(style: .normal, title: "Edit") { (action, view, success) in
        
            let exerciseVC = ExerciseController(style: .plain)
            exerciseVC.exercise = self.exercises[indexPath.row]
            self.navigationController?.pushViewController(exerciseVC, animated: true)
        }
        
        let swipeDelete = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in

            let exercise =  self.exercises.remove(at: indexPath.row)
            CoreDataManager.shared.deleteExersis(exercise: exercise)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.isVisibleButton()
            print("Delete cell swipe TEST")
        }
        
        swipeEdit.backgroundColor = .systemBlue
        swipeDelete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [swipeDelete, swipeEdit])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

