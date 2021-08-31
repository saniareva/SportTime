//
//  TimesCell.swift
//  SportTime
//
//  Created by Alex on 20.05.2021.
//

import UIKit



class TimesExerciseCell: UITableViewCell {
    
    let timeExercise = UILabel()
    let descriptionTimeExercise = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.gray
        timeExercise.backgroundColor = UIColor.yellow
        descriptionTimeExercise.backgroundColor = UIColor.green
        
        contentView.addSubview(timeExercise)
        contentView.addSubview(descriptionTimeExercise)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width
        
        timeExercise.frame = CGRect(x: 5 , y: 2, width: (widthcontentView / 3) - 5 , height: heightcontentView - 4)
        timeExercise.textAlignment = NSTextAlignment.center
        
        let descriptionTimeExerciseX = timeExercise.frame.origin.x + timeExercise.frame.width + 5
        let descriptionTimeExerciseWidth = widthcontentView - (timeExercise.frame.width + 5) - 5
        descriptionTimeExercise.frame = CGRect(x: descriptionTimeExerciseX , y: 2, width: descriptionTimeExerciseWidth , height: heightcontentView - 4)
        descriptionTimeExercise.textAlignment = NSTextAlignment.center
    }
}
