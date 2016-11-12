//
//  ViewController.swift
//  Gradient Transitioning
//
//  Created by Steven Hurtado on 11/11/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var gtLabel: UILabel!
    
    @IBOutlet var gtView: UIView!
    
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    var cont = true
    
    var red1: CGFloat = CGFloat(arc4random_uniform(256))
    var green1: CGFloat = CGFloat(arc4random_uniform(256))
    var blue1: CGFloat = CGFloat(arc4random_uniform(256))
    var redBool: Bool = true
    var greenBool: Bool = true
    var blueBool: Bool = true
    
    var timer = Timer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.gtLabel.layer.shadowColor = UIColor.black.cgColor
        self.gtLabel.layer.shadowOpacity = 1
        self.gtLabel.layer.shadowOffset = CGSize.init(width: 5, height:5)
        self.gtLabel.layer.shadowRadius = 10
        
        goBtn.layer.borderWidth = 5
        goBtn.layer.borderColor = UIColor.white.cgColor
        goBtn.layer.cornerRadius = 10
        
        stopBtn.layer.borderWidth = 5
        stopBtn.layer.borderColor = UIColor.white.cgColor
        stopBtn.layer.cornerRadius = 10
        
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(movement), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func movement()
    {
        //gradient animation
        if(cont)
        {
            backgroundAnimation(r1: red1, g1: green1, b1: blue1)
        }
    }
    
    func backgroundAnimation(r1: CGFloat, g1: CGFloat, b1: CGFloat)
    {
        let red1Temp = r1
        let green1Temp = g1
        let blue1Temp = b1
        
        var red2: CGFloat
        var green2: CGFloat
        var blue2: CGFloat
        
        if(redBool)
        {
            red2 = r1 + 0.1*CGFloat(arc4random_uniform(8))
        }
        else
        {
            red2 = r1 - 0.1*CGFloat(arc4random_uniform(8))
        }
        
        if(greenBool)
        {
            green2 = g1 + 0.1*CGFloat(arc4random_uniform(8))
        }
        else
        {
            green2 = g1 - 0.1*CGFloat(arc4random_uniform(8))
        }
        
        if(blueBool)
        {
            blue2 = b1 + 0.1*CGFloat(arc4random_uniform(8))
        }
        else
        {
            blue2 = b1 - 0.1*CGFloat(arc4random_uniform(8))
        }
        
        
        if(red2 >= 255)
        {
            red2 = 255
            redBool = false
        }
        else if(red2 <= 0)
        {
            red2 = 0
            redBool = true
        }
        
        if(green2 >= 255)
        {
            green2 = 255
            greenBool = false
        }
        else if(green2 <= 0)
        {
            green2 = 0
            greenBool = true
        }
        
        if(blue2 >= 255)
        {
            blue2 = 255
            blueBool = false
        }
        else if(blue2 <= 0)
        {
            blue2 = 0
            blueBool = true
        }
        
        
        let topColor = UIColor(red: (red1Temp/255.0), green: (green1Temp/255.0), blue: (blue1Temp/255.0), alpha: 0.7)
        
        let bottomColor = UIColor(red: (red2/255.0), green: (green2/255.0), blue: (blue2/255.0), alpha: 0.7)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?

        gradientLayer.frame = self.view.bounds
        
        self.gtView.layer.sublayers?.removeAll()
        self.gtView.layer.insertSublayer(gradientLayer, at: 0)
        
        self.view.sendSubview(toBack: gtView)
        
        self.red1 = red2
        self.green1 = green2
        self.blue1 = blue2
    }

    @IBAction func go(_ sender: Any)
    {
        cont = true
    }
    
    @IBAction func stop(_ sender: Any)
    {
        cont = false
    }

}

