//
//  ViewController.swift
//  VerticalSteppedSlider
//
//  Created by mludowise on 09/27/2017.
//  Copyright (c) 2017 mludowise. All rights reserved.
//

import UIKit
import VerticalSteppedSlider

class ViewController: UIViewController {

    @IBOutlet weak var slider1: VSSlider!
    @IBOutlet weak var slider2: VSSlider!
    @IBOutlet weak var slider3: VSSlider!
    @IBOutlet weak var slider4: VSSlider!
    @IBOutlet weak var slider5: VSSlider!
    @IBOutlet weak var slider6: VSSlider!
    
    @IBOutlet weak var actualLabel1: UILabel!
    @IBOutlet weak var actualLabel2: UILabel!
    @IBOutlet weak var actualLabel3: UILabel!
    @IBOutlet weak var actualLabel4: UILabel!
    @IBOutlet weak var actualLabel5: UILabel!
    @IBOutlet weak var actualLabel6: UILabel!
    
    @IBOutlet weak var roundedLabel1: UILabel!
    @IBOutlet weak var roundedLabel2: UILabel!
    @IBOutlet weak var roundedLabel3: UILabel!
    @IBOutlet weak var roundedLabel4: UILabel!
    @IBOutlet weak var roundedLabel5: UILabel!
    @IBOutlet weak var roundedLabel6: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slider1VaueChanged(_ sender: Any) {
        actualLabel1.text = String(format: "%.02f", slider1.value)
        roundedLabel1.text = String(format: "%.02f", slider1.roundedValue)
    }
    
    @IBAction func slider2VaueChanged(_ sender: Any) {
        actualLabel2.text = String(format: "%.02f", slider2.value)
        roundedLabel2.text = String(format: "%.02f", slider2.roundedValue)
    }
    
    @IBAction func slider3VaueChanged(_ sender: Any) {
        actualLabel3.text = String(format: "%.02f", slider3.value)
        roundedLabel3.text = String(format: "%.02f", slider3.roundedValue)
    }
    
    @IBAction func slider4VaueChanged(_ sender: Any) {
        actualLabel4.text = String(format: "%.02f", slider4.value)
        roundedLabel4.text = String(format: "%.02f", slider4.roundedValue)
    }
    
    @IBAction func slider5VaueChanged(_ sender: Any) {
        actualLabel5.text = String(format: "%.02f", slider5.value)
        roundedLabel5.text = String(format: "%.02f", slider5.roundedValue)
    }
    
    @IBAction func slider6VaueChanged(_ sender: Any) {
        actualLabel6.text = String(format: "%.02f", slider6.value)
        roundedLabel6.text = String(format: "%.02f", slider6.roundedValue)
    }
    
}

