//
//  ViewController.swift
//  SportTime
//
//  Created by Alex on 15.12.2020.
//

import UIKit
import CoreData




class AllExercisesController: UIViewController {
    
    
    
    let listTable = UITableView()
    var listExercises: [ListExercises] = []
  
    var delete = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: -- получение данных с помощью NSFetchRequest -- CoreData
        listExercises = CoreDataManager.shared.getAllExercises()
        listTable.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTable.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
        createTable()
        
        title = "List"
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(createNewList))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func createNewList() {

        let listExecisesController = ListExercisesController()
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let listExercises = ListExercises(context: context)
        CoreDataManager.shared.saveContext()
        listExecisesController.listExercises = listExercises
        navigationController?.pushViewController(listExecisesController, animated: true)
    }
    
    
    func createTable() {
        listTable.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        listTable.backgroundColor = .lightGray
        listTable.delegate = self
        listTable.dataSource = self
        listTable.backgroundColor = .yellow
        print("Frame table - \(self.listTable.frame)")
        self.view.addSubview(listTable)
    }
    
    deinit {
        print("deinit ListViewController")
    }
}
//MARK: - Table View

extension AllExercisesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifire = "ListCell"
        let exercises = listExercises[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as? ListTableViewCell {
            cell.lableCell.text = exercises.countExercises
            cell.lableName.text = exercises.name
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailedListController()
        let navController = UINavigationController(rootViewController: detailVC)
        let lostExercises = listExercises[indexPath.row]
        
        detailVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        navController.modalPresentationStyle = .fullScreen
        detailVC.title = listExercises[indexPath.row].name
        detailVC.listExercises = lostExercises
        self.present(navController, animated: true, completion: nil)
        print("touch to cell \(indexPath.row)")
    }
    
    // свайп справа на лево
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     
            let swipeEdit = UIContextualAction(style: .normal, title: "Edit") { (action, view, success) in
            
                let listExerciseVC = ListExercisesController()
                listExerciseVC.listExercises = self.listExercises[indexPath.row]
                
                self.navigationController?.pushViewController(listExerciseVC, animated: true)
            }
            
            let swipeDelete = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
                let listExercise = self.listExercises.remove(at: indexPath.row)
                CoreDataManager.shared.deleteListExercises(listExercises: listExercise)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
            swipeEdit.backgroundColor = .systemBlue
            swipeDelete.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [swipeDelete, swipeEdit])
        }
}

