//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Hasan Uysal on 7.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let kennyImage = UIImage(named: "kenny")
    let uiimageView = UIImageView()
    let timerLabel = UILabel()
    let scoreLabel = UILabel()
    let hScoreLabel = UILabel()
    var timer = Timer()
    var score = 0
    var hScore = 0
    var counter = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        uiimageView.contentMode = UIView.ContentMode.scaleToFill
        uiimageView.frame.size.width = width * 0.25
        uiimageView.frame.size.height = height * 0.15
        uiimageView.center = CGPoint(x: width * 0.25, y: height * 0.35)
        uiimageView.image = kennyImage
        
        uiimageView.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapTheKenny))
        uiimageView.addGestureRecognizer(tapGR)
        
        timerLabel.text = "Time Left : \(counter)"
        timerLabel.textAlignment = .center
        timerLabel.frame = CGRect(x: width * 0.5 - ((width-50)/2), y: height * 0.1, width: width - 50, height: height * 0.05)
        timerLabel.textColor = .white
        timerLabel.backgroundColor = .orange
        timerLabel.shadowColor = .black
        timerLabel.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        
        scoreLabel.text = "Score : \(score)"
        scoreLabel.textAlignment = .center
        scoreLabel.frame = CGRect(x: width * 0.5 - ((width-50)/2), y: height * 0.15 + 10, width: width - 50, height: height * 0.05)
        scoreLabel.textColor = .white
        scoreLabel.backgroundColor = .orange
        scoreLabel.shadowColor = .black
        scoreLabel.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        
        hScoreLabel.text = "High Score : \(hScore)"
        hScoreLabel.textAlignment = .center
        hScoreLabel.frame = CGRect(x: width * 0.5 - ((width-50)/2), y: height * 0.9, width: width - 50, height: height * 0.05)
        hScoreLabel.textColor = .white
        hScoreLabel.backgroundColor = .orange
        hScoreLabel.shadowColor = .black
        hScoreLabel.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        addViews(views: [uiimageView, timerLabel, scoreLabel, hScoreLabel])
        
        
        
    }
    
    func addViews(views: [UIView]){
        
        for view in views {
            self.view.addSubview(view)
        }
    }
    
    @objc func tapTheKenny(){
        
        self.score += 1
        self.scoreLabel.text = "Score : \(self.score)"
        
    }
    
    @objc func timerFunc(){
        
        if counter == 1 {
            timer.invalidate()
        }
        
        self.counter -= 1
        timerLabel.text = "Time Left : \(counter)"
    }

}

