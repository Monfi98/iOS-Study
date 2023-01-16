//
//  ViewController.swift
//  MyFirstApp
//
//  Created by 신승재 on 2023/01/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
    }

    @IBAction func didTabButton(_ sender: Any) {
        mainLabel.text = "안녕하세요"
        mainLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myButton.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    
}

