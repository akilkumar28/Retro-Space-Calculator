//
//  ViewController.swift
//  Retro Space Calculator
//
//  Created by AKIL KUMAR THOTA on 12/21/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController {
    
    @IBOutlet weak var outputlbl: UILabel!
    var btnsound : AVAudioPlayer!
    
    
    
    
    enum Operations : String {
        case Add 
        case Multuply
        case Divide
        case Subtract
        case Empty
        
    }
    var currentoperation = Operations.Empty
    var leftvalstr = ""
    var rightvalstr = ""
    var result = ""
    var runningnumber = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputlbl.text = "0"
        
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let url = URL(fileURLWithPath: path!)
        
        
        do{
            try btnsound = AVAudioPlayer(contentsOf: url)
            btnsound.prepareToPlay()

            
        } catch let err as NSError{
            
            print(err.debugDescription)
            
        }
    }
    
    func playsound() {
        btnsound.play()
    }
    
    @IBAction func btnPressd(sender: UIButton) {
        
        playsound()
        runningnumber += "\(sender.tag)"
        outputlbl.text = runningnumber
    }
    
    @IBAction func onADDPressd(sender:AnyObject) {
        
        performOperation(operation: .Add)
    }
    @IBAction func onSubPressd(sender:AnyObject) {
        
        performOperation(operation: .Subtract)
    
    }
    @IBAction func onMULPressd(sender:AnyObject) {
        
        performOperation(operation: .Multuply)
    }
    @IBAction func onDIVPressd(sender:AnyObject) {
        performOperation(operation: .Divide)
    }
    @IBAction func onEQLPressd(sender:AnyObject) {
        
        performOperation(operation: currentoperation)
    }
    
    func performOperation(operation: Operations) {
        playsound()
        if currentoperation != Operations.Empty {
            if runningnumber != ""{
                rightvalstr = runningnumber
                runningnumber = ""
                
                if currentoperation == Operations.Add {
                    result = "\(Double(leftvalstr)! + Double(rightvalstr)!)"
                } else if currentoperation == Operations.Subtract{
                    result = "\(Double(leftvalstr)! - Double(rightvalstr)!)"
                } else if currentoperation == Operations.Multuply {
                    result = "\(Double(leftvalstr)! * Double(rightvalstr)!)"
                } else if currentoperation == Operations.Divide {
                    result = "\(Double(leftvalstr)! / Double(rightvalstr)!)"

                }
                leftvalstr = result
                outputlbl.text = result
                
             }
             currentoperation = operation
            
        } else {
            leftvalstr = runningnumber
            runningnumber = ""
            currentoperation = operation
        }
    }
    @IBAction func clearprssd(_ sender: UIButton) {
        playsound()
        rightvalstr = ""
        leftvalstr = ""
        currentoperation = Operations.Empty
        outputlbl.text = "0"
        result = ""
        runningnumber = ""
    }
}

