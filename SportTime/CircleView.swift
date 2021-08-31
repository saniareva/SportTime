//
//  CircleView.swift
//  SportTime
//
//  Created by Alex on 10.06.2021.
//

import UIKit

class CircleView: UIView {

    var label = UILabel()
    var allSeconds = Int()
    let shapeLayer = CAShapeLayer()
    var changeColor = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabel() {
        label.text = String(allSeconds)
        label.textColor = .black
        label.numberOfLines = 20
        label.textAlignment = .center
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        
   
        self.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        
        addSubview(label)
    }
    
    func time(get timeMin: Int, timeSec: Int, allTime: Int) {
        var getTime = allTime
        label.text = String(format: "%02d", timeMin) + " : " +  String(format: "%02d", timeSec) + " all" + String(getTime)
        self.allSeconds = getTime
        print("func time(get time: Double) \(self.allSeconds)")
    }
    
    
    //MARK: Animation Circle
    
    func animationCircualr() {
        let center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let starAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: starAngle, endAngle: endAngle, clockwise: false)
       
        let trackShape = CAShapeLayer()
        trackShape.path = circularPath.cgPath
        trackShape.lineWidth = 21
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.strokeColor = #colorLiteral(red: 0.836012423, green: 0.8294197321, blue: 0.8410528302, alpha: 1).cgColor
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        self.layer.addSublayer(trackShape)
        self.layer.addSublayer(shapeLayer)
    }
    
    func colorCilcular(change: Bool) {
        if change == true {
            shapeLayer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
        } else {
            shapeLayer.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor
        }
    }
    
    func basicAnimation(timeDuration: Double) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(timeDuration)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    func pauseAnimation() {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    
    deinit {
        print("deinit CircleView")
    }
    

}
