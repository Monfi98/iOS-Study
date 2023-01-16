//
//  ViewController.swift
//  UpDownGame
//
//  Created by 신승재 on 2023/01/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var comNumber: Int = 0
    var myNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard let numString = sender.currentTitle else { return }
        numberLabel.text = numString
        
        guard let num = Int(numString) else { return }
        myNumber = num
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        if comNumber > myNumber {
            mainLabel.text = "Up"
        } else if comNumber < myNumber {
            mainLabel.text = "Down"
        } else {
            mainLabel.text = "Correct!"
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        reset()
    }
    
    func reset() {
        mainLabel.text = "선택하세요."
        numberLabel.text = ""
        
        comNumber = Int.random(in: 1...10)
        myNumber = 0
    }
}

