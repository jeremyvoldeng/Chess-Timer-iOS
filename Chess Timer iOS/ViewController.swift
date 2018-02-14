//
//  ViewController.swift
//  Chess Timer iOS
//
//  Created by Jeremy Voldeng on 2018-02-14.
//  Copyright © 2018 Jeremy Voldeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Config {
        static var timerLength: Double = 65
    }

    var timeRemaining = Config.timerLength {
        didSet {
            timerLabel.text = formattedTime(timeRemaining)
        }
    }

    var gameTimer = Timer()
    var timerIsRunning = false

    @IBOutlet weak var timerLabel: UILabel!

    @IBAction func startButton(_ sender: UIButton) {
        if timerIsRunning == false {
            startTimer()
            timerIsRunning = true
        }
    }

    @IBAction func resetButton(_ sender: UIButton) {
        timeRemaining = Config.timerLength
    }

    func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 0.1
            if timeRemaining <= 0 {
                timeRemaining = 0
                view.backgroundColor = #colorLiteral(red: 1, green: 0.06543179506, blue: 0, alpha: 0.741411601)
            }
        }
    }

    func formattedTime(_ time: Double) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time - Double(minutes) * 60)
        let milliseconds = Int((time - Double(minutes) * 60 - Double(seconds)) * 10)
        let formattedString: String!

        if minutes == 0 {
            formattedString = "\(seconds).\(milliseconds)"
        } else {
            if minutes < 10 {
                formattedString =  "\(minutes):0\(seconds)"
            } else {
                formattedString = "\(minutes):\(seconds)"
            }
        }
        return formattedString
    }
}

