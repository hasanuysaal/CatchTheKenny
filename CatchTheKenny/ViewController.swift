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
    var kennyTimer = Timer()
    var score = 0
    var hScore = 0
    var counter = 10
    var kennyPoints = [CGPoint]()
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        kennyPoints = [
            CGPoint(x: width * 0.20, y: height * 0.35),
            CGPoint(x: width * 0.50, y: height * 0.35),
            CGPoint(x: width * 0.80, y: height * 0.35),
            CGPoint(x: width * 0.20, y: height * 0.59),
            CGPoint(x: width * 0.50, y: height * 0.59),
            CGPoint(x: width * 0.80, y: height * 0.59),
            CGPoint(x: width * 0.20, y: height * 0.73),
            CGPoint(x: width * 0.50, y: height * 0.73),
            CGPoint(x: width * 0.80, y: height * 0.73)
        ]
        
        uiimageView.contentMode = UIView.ContentMode.scaleToFill
        uiimageView.frame.size.width = width * 0.25
        uiimageView.frame.size.height = height * 0.15
        uiimageView.image = kennyImage
        uiimageView.isHidden = true
        
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
        scoreLabel.frame = CGRect(x: width * 0.5 - ((width-50)/2), y: height * 0.17, width: width - 50, height: height * 0.05)
        scoreLabel.textColor = .white
        scoreLabel.backgroundColor = .orange
        scoreLabel.shadowColor = .black
        scoreLabel.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        
        if let highScore = UserDefaults.standard.object(forKey: "hScore") as? Int {
            hScore = highScore
            hScoreLabel.text = "High Score : \(hScore)"
        } else {
            hScoreLabel.text = "High Score : \(hScore)"
        }
        
        hScoreLabel.textAlignment = .center
        hScoreLabel.frame = CGRect(x: width * 0.5 - ((width-50)/2), y: height * 0.9, width: width - 50, height: height * 0.05)
        hScoreLabel.textColor = .white
        hScoreLabel.backgroundColor = .orange
        hScoreLabel.shadowColor = .black
        hScoreLabel.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(kennyTimerFunc), userInfo: nil, repeats: true)
        
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
    
    
    @objc func kennyTimerFunc(){
        
        let random = Int(arc4random_uniform(UInt32(self.kennyPoints.count - 1)))
        self.uiimageView.center = self.kennyPoints[random]
        self.uiimageView.isHidden = false
        
    }
    
    @objc func timerFunc(){
        
        self.counter -= 1
        self.timerLabel.text = "Time Left : \(self.counter)"
        
        if counter == 0 {
            self.uiimageView.isHidden = true
            self.timer.invalidate()
            self.kennyTimer.invalidate()
            
            if self.score > self.hScore {
                self.hScore = self.score
                UserDefaults.standard.set(self.hScore, forKey: "hScore")
                self.hScoreLabel.text = "High Score : \(hScore)"
            }
            
            self.alert = UIAlertController(title: "Time's up", message: "Do you want to play again?", preferredStyle: .alert)
            let noBtn = UIAlertAction(title: "NO", style: .default, handler: nil)
            let yesBtn = UIAlertAction(title: "YES", style: .default) { UIAlertAction in
                self.counter = 10
                self.timerLabel.text = "Time Left : \(self.counter)"
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
                
                self.kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.kennyTimerFunc), userInfo: nil, repeats: true)
                
            }
            self.alert.addAction(yesBtn)
            self.alert.addAction(noBtn)
            self.present(self.alert, animated: true, completion: nil)
            
        }
    }
}

