//
//  ViewController.swift
//  RPSGame
//
//  Created by 신승재 on 2023/01/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    var myChoice: Rps = Rps.rock
    var comChoice: Rps = Rps(rawValue: Int.random(in: 0...2))!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    func reset() {
        mainLabel.text = "선택하세요!"
        comImageView.image = #imageLiteral(resourceName: "ready")
        myImageView.image = #imageLiteral(resourceName: "ready")
        comChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"
        comChoice = Rps(rawValue: Int.random(in: 0...2))!
    }

    @IBAction func didTapRPSButton(_ sender: UIButton) {
        let buttonTitle = sender.currentTitle!
        
        switch buttonTitle {
        case "가위":
            myChoice = .scissors
        case "바위":
            myChoice = .rock
        case "보":
            myChoice = .paper
        default:
            break
        }
        
    }
    
    
    @IBAction func didTapSelectButton(_ sender: UIButton) {
        switch comChoice {
        case .rock:
            comImageView.image = #imageLiteral(resourceName: "rock")
            comChoiceLabel.text = "바위"
        case .scissors:
            comImageView.image = #imageLiteral(resourceName: "scissors")
            comChoiceLabel.text = "가위"
        case .paper:
            comImageView.image = #imageLiteral(resourceName: "paper")
            comChoiceLabel.text = "보"
        }
        
        switch myChoice {
        case .rock:
            myImageView.image = #imageLiteral(resourceName: "rock")
            myChoiceLabel.text = "바위"
        case .scissors:
            myImageView.image = #imageLiteral(resourceName: "scissors")
            myChoiceLabel.text = "가위"
        case .paper:
            myImageView.image = #imageLiteral(resourceName: "paper")
            myChoiceLabel.text = "보"
        }
        
        if comChoice == myChoice {
            mainLabel.text = "비겼다!"
        } else if comChoice == .rock && myChoice == .paper {
            mainLabel.text = "이겼다!"
        } else if comChoice == .scissors && myChoice == .rock {
            mainLabel.text = "이겼다!"
        } else if comChoice == .paper && myChoice == .scissors {
            mainLabel.text = "이겼다!"
        } else {
            mainLabel.text = "졌다!"
        }
    }
    
    @IBAction func didTapResetButton(_ sender: UIButton) {
        reset()
    }
    
}
