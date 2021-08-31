//
//  DetailViewController.swift
//  SportTime
//
//  Created by Alex on 15.12.2020.
//

import UIKit

class DetailedListController: UIViewController {
    
    let deteilTaible = UITableView()
    let controlView = UIView()
    let progresView = UIProgressView()
    let stopTimer = UIButton()
    let startPause = UIButton()
    var myTimer = Timer()
    var timeExercise:Int = 0
    var timeRelax:Int = 0
    
    var createTimeEx: (min: Int, sec: Int, all: Int) = (min: 0, sec: 0, all: 0)
    var createTimeRelax: (min: Int, sec: Int, all: Int) = (min: 0, sec: 0, all: 0)
    
    var timeTest = 0
    
    var timeSec = 0
    var timeMin = 0
    
    
    var animateStart = 0
    
    var circle = CircleView()
    
    var exercise = true
    var exercises: [Exercise] = []
    var listExercises: ListExercises!
    
    var numberElements = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        exercises = CoreDataManager.shared.getExercises(for: listExercises)
        deteilTaible.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        createUiView()

        let backButton = UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(createBackButton))
        self.navigationItem.leftBarButtonItem = backButton
        self.deteilTaible.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
    }
    
    //MARK: - create Table
    func createTable() {
        deteilTaible.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 1.2)
        deteilTaible.delegate = self
        deteilTaible.dataSource = self
        deteilTaible.backgroundColor = .lightGray
        self.view.addSubview(deteilTaible)
    }
    //MARK: - create UiView
    func createUiView() {
        let controlViewY = self.view.frame.height - (self.view.frame.height - deteilTaible.frame.height)
        controlView.frame = CGRect(x: 0, y: controlViewY, width: self.view.frame.width, height: self.view.frame.height - deteilTaible.frame.height)
        controlView.backgroundColor = .lightGray
        createButtons(view: controlView)
        createProgressView(view: controlView)
        self.view.addSubview(controlView)
    }
    
    //MARK: - create Progress UiView
    func createProgressView(view: UIView) {
        progresView.frame = CGRect(x: 0, y: 5, width: view.frame.width, height: view.frame.height)
        progresView.trackTintColor = .white
        progresView.progressTintColor = .red
        progresView.setProgress(0, animated: true)
        view.addSubview(progresView)
    }
    
    //MARK: - create Buttons
    func createButtons(view: UIView) {
        let heightButtons = view.frame.height / 1.5
        let buttonsY = view.frame.height / 2
        let stopTimer = UIButton(frame: CGRect(x: 40, y: buttonsY - (heightButtons / 2), width: heightButtons, height: heightButtons))
        stopTimer.layer.cornerRadius = stopTimer.bounds.height / 2
        stopTimer.setTitle("Stop", for: .normal)
        stopTimer.backgroundColor = .green
        stopTimer.setTitleColor(.black, for: .normal)
        stopTimer.addTarget(self, action: #selector(stopFunc), for: .touchUpInside)
        
        let startButtonX = view.frame.width - stopTimer.frame.width - stopTimer.frame.origin.x
        startPause.frame = CGRect(x: startButtonX, y: stopTimer.frame.origin.y, width: heightButtons, height: heightButtons)
        startPause.layer.cornerRadius = stopTimer.bounds.height / 2
        startPause.setTitle("Start", for: .normal)
        startPause.backgroundColor = .red
        startPause.setTitleColor(.black, for: .normal)
        startPause.addTarget(self, action: #selector(startFunc), for: .touchUpInside)
        
        view.addSubview(startPause)
        view.addSubview(stopTimer)
    }
    
    @objc func startFunc() {
        if startPause.isSelected == false {
            
            if animateStart == 0 {
                selectionCell()
                startPause.backgroundColor = .yellow
                startPause.setTitle("Pause", for: .normal)
                startPause.isSelected = true
            } else if animateStart == 1 {
                circle.resumeAnimation()
                startPause.backgroundColor = .yellow
                startPause.setTitle("Pause", for: .normal)
                startPause.isSelected = true
                
                
            }
            
          //  if animateStart == true {
                //selectionCell()
            //} else {
              //  animateStart = false
              //  circle.resumeAnimation()
//                startPause.backgroundColor = .yellow
//                startPause.setTitle("Pause", for: .normal)
//                startPause.isSelected = true
           // }
            

            
            
             print("startFunc  otschet ")
        } else {
            pauseTimer()
        }
    }
    
    
    func selectionCell() {
        if numberElements <= 0 && timeTest <= 0 {
            elementInIndex()
            circleFunc()
        } else {
            if exercise == true {
                circleFunc()
                circle.colorCilcular(change: true)
                circle.basicAnimation(timeDuration: Double(timeExercise))
                circle.time(get: timeMin, timeSec: timeSec, allTime: timeTest)
                myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerProgres), userInfo: nil, repeats: true)
            } else {
                myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRelax), userInfo: nil, repeats: true)
            }
        }

    }
    
    
    func pauseTimer() {
        myTimer.invalidate()
        animateStart = 1
        //circle.pauseAnimation()
        startPause.backgroundColor = .red
        startPause.setTitle("Start", for: .normal)
        startPause.isSelected = false
        print("startFunc  pause ")
        
        
    }
    
    
    @objc func timerProgres() {
       
        let timeToTimer = 1.0 / Double(timeExercise)
        if timeTest != 0 {
      //  if progresView.progress != 1.0 {
           
            progresView.progress += Float(timeToTimer)
           
            if timeSec == 0 && timeMin != 0{
                timeMin -= 1
                timeSec = 59
            
            } else if timeMin == 0 {
                timeSec = timeTest
            }
            timeTest -= 1
            timeSec -= 1
            circle.time(get: timeMin, timeSec: timeSec, allTime: timeTest)
            print("timer \(timeTest)")
        } else {
            myTimer.invalidate()
            progresView.progressTintColor = .green
            progresView.progress = 0.0
           // circle.time(get: 0, timeSec: 0, allTime: timeTest)
            print("Timer is finish")
            exercise = false
            circle.colorCilcular(change: false)
            timeTest = Int(timeRelax)
            circle.basicAnimation(timeDuration: Double(timeRelax))
            timeMin = createTimeRelax.min
            timeSec = createTimeRelax.sec
            timeTest = createTimeRelax.all
            circle.time(get: timeMin, timeSec: timeSec, allTime: timeTest)
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                           selector: #selector(timerRelax), userInfo: nil, repeats: true)
        }
        print("numberElements timer() ------ \(numberElements)")
    }
    
    @objc func timerRelax() {
        let timeToTimer = 1.0 / Double(timeRelax)
        
        if timeTest != 0 {
       // if progresView.progress != 1.0 {
            progresView.progress += Float(timeToTimer)
            
            circle.time(get: timeMin, timeSec: timeSec, allTime: timeTest)
            if timeSec == 0 {
                timeMin -= 1
                timeSec = 59
            } else if timeMin == 0 {
                timeSec = timeTest
            }
            timeTest -= 1
            timeSec -= 1
            
            
            print("timerRelax \(timeTest)")
        } else {
            myTimer.invalidate()
            startPause.backgroundColor = .red
            progresView.progressTintColor = .red
            startPause.setTitle("Start", for: .normal)
            progresView.progress = 0.0
            deteilTaible.reloadData()
            exercise = true
          //  circle.time(get: 0, timeSec: 0, allTime: 0)
            numberElements += 1
            elementInIndex()
            deteilTaible.reloadData()
        }
        print("numberElements timer() ------ \(numberElements)")
    }
    
    
    @objc func stopFunc() {
        startPause.backgroundColor = .red
        progresView.progressTintColor = .red
        startPause.setTitle("Start", for: .normal)
        startPause.isSelected = false
        exercise = true
        timeTest = 0
        circle.time(get: timeMin, timeSec: timeSec, allTime: timeTest)
        circle.colorCilcular(change: true)
        circle.removeFromSuperview()
        myTimer.invalidate()
        progresView.progress = 0.0
        print("stopFunc")
    }
    
    @objc func createBackButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        print("deinit DetailViewController")
    }
}


extension DetailedListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell

        if cell == nil {
            cell = UITableViewCell() as! DetailTableViewCell
        }
        cell.myDelegate = self
        cell.labelName.text = exercises[indexPath.row].name
        cell.labelEx.text =  "Ex \(String(describing: exercises[indexPath.row].timeExercise ?? "00:00"))"
        cell.labelRelax.text = "R \(String(describing: exercises[indexPath.row].timeRelax ?? "00:00"))"
        cell.labelDeskription.text = exercises[indexPath.row].descriptionEx
        let imgStr = exercises[indexPath.row].img
        if imgStr == nil {
            cell.images.image = UIImage(named: "youtube")
        } else {
            let image = Bace64String().decodingToImage(imageString: imgStr!)
            cell.images.image = image
        }
        if indexPath.row < numberElements {
            cell.backgroundColor = .blue
        } else if indexPath.row == numberElements {
            cell.backgroundColor = .yellow
        } else {
            cell.backgroundColor = .gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
       // stopFunc()
        numberElements = indexPath.row
        createTimeEx = CreateTime().createTime(stringFor: exercises[indexPath.row].timeExercise!)
        createTimeRelax = CreateTime().createTime(stringFor: exercises[indexPath.row].timeRelax!)
        self.timeExercise = createTimeEx.all
        self.timeRelax = createTimeRelax.all
        timeTest = Int(self.timeExercise)
        timeMin = createTimeEx.min
        timeSec = createTimeEx.sec
       
        circle.time(get: timeTest, timeSec: timeTest, allTime: timeTest)
       
      //  let timeRelax = CreateTime().createTime(stringFor: exercises[indexPath.row].timeRelax!)
        
        
        print(exercises[indexPath.row].timeExercise, exercises[indexPath.row].timeRelax)
        
        print(self.timeExercise, self.timeRelax)
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
        }
        swipeEdit.backgroundColor = .systemBlue
        swipeDelete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [swipeDelete, swipeEdit])
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension DetailedListController: DetailTableViewCellDelegate {
    func infoCell(deskription: String) {
        let allert = UIAlertController(title: "Info", message: deskription, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        present(allert, animated: true, completion: nil)
    }
}

extension DetailedListController {

    func elementInIndex() {
        for (i, v) in exercises.enumerated() {
            if i == numberElements {
                
                createTimeEx = CreateTime().createTime(stringFor: v.timeExercise!)
                createTimeRelax = CreateTime().createTime(stringFor: v.timeRelax!)
                
                self.timeExercise = createTimeEx.all
                self.timeRelax = createTimeRelax.all
                //self.timeExercise = CreateTime().createTime(stringFor: v.timeExercise!)
                //self.timeRelax = CreateTime().createTime(stringFor: v.timeRelax!)
                print("\(i), \(v)")
                timeTest = Int(timeExercise)
                timeMin = createTimeEx.min
                timeSec = createTimeEx.sec
                circle.time(get: timeMin, timeSec: timeSec, allTime: timeTest)
                circle.basicAnimation(timeDuration: Double(timeExercise))
                circle.colorCilcular(change: true)
                myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerProgres), userInfo: nil, repeats: true)
               
                deteilTaible.reloadData()
            } else {
                progresView.progress = 0.0
            }
        }
    }
}

//MARK: Circle
extension DetailedListController {
    
    func circleFunc() {
        circle.frame.size = CGSize(width: view.frame.width - 50, height: view.frame.width - 50)
        circle.center = CGPoint(x: view.frame.width / 2 , y: view.frame.height / 2)
        circle.animationCircualr()
       // circle.time(get: <#T##Double#>)
        circle.createLabel()
        circle.backgroundColor = .clear
        self.view.addSubview(circle)

    }
 
}
