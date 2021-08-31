//
//  GetCorrectTime.swift
//  SportTime
//
//  Created by Alex on 29.05.2021.
//

import UIKit

class CreateTime {
    
    
var min = 0
var sec = 0
    
    
    func createTime(stringFor time: String) -> (min: Int, sec: Int, all: Int){
    
    let myTime = sort(text: time)

    var timeMM:Double = 0
    var timeSS:Double = 0
    let formatter = DateFormatter()
    formatter.dateFormat = "mm:ss"
    
    guard let dateExercise = formatter.date(from: myTime) else {
        return (min: 0, sec: 0, all: 0)
       // return 00.00
    }

    formatter.dateFormat = "mm"
    timeMM = Double(formatter.string(from: dateExercise))!
    formatter.dateFormat = "ss"
    timeSS = Double(formatter.string(from: dateExercise))!
    
   
        return (min: Int(timeMM), sec: Int(timeSS),  all: Int((timeMM * 60) + timeSS))
  //  return (timeMM * 60) + timeSS
 
}

func sort(text: String) -> String {
    var textMy = String()
    let num:[Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":"]

    for i in text {
        for c in num {
            if i == c {
                textMy.append(i)
            }
        }
    }
    
    return textMy
    }
}
