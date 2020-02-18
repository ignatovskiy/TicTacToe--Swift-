//
//  ViewController.swift
//  TicTacToe
//
//  Copyright © 2020 Ignatovskiy Nikita. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var Button0: UIButton!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
    
    @IBOutlet weak var gameStatusLabel: UILabel!
    
    @IBOutlet weak var xCounterLabel: UILabel!
    @IBOutlet weak var oCounterLabel: UILabel!
    
    let gameOverCombinations: Array = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    lazy var buttonsList = [Button0, Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8]
    
    var xCounter: Int = 0
    var oCounter: Int = 0
    
    var currentPlayer: String = "Cross"
    var currentCellsState: Array = ["Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
    var isGameFinished: Bool = false
    
    
    @IBAction func cellButtonClicked(_ sender: AnyObject)
    {
        func gameProcess(_ sender: AnyObject)
        {
                let isCellEmpty = checkCell(sender)
                if isCellEmpty && !isGameFinished
                {
                    makeStep(sender)
                    checkGameOverCombinations()
                }
        }
        
        func checkCell(_ sender: AnyObject) -> Bool
        {
            if (currentCellsState[sender.tag] == "Empty") {return true} else {return false}
        }
        
        func makeStep(_ sender: AnyObject)
        {
            currentCellsState[sender.tag] = currentPlayer
            
            func makeNougth(_ sender: AnyObject)
            {
                sender.setImage(UIImage(named: "nougth.png"), for: UIControl.State())
                currentPlayer = "Cross"
            }
            
            func makeCross(_ sender: AnyObject)
            {
                sender.setImage(UIImage(named: "cross.png"), for: UIControl.State())
                currentPlayer = "Nougth"
            }
            
            if (currentPlayer == "Cross")
            {
                makeCross(sender)
            }
            else if (currentPlayer == "Nougth")
            {
                makeNougth(sender)
            }
            
        }
        
        func checkGameOverCombinations()
        {
            func checkWinSign(_ sign: String)
            {
                playAgain.isHidden = false
                
                func proccedCrossWin()
                {
                    xCounter += 1
                    xCounterLabel.text = String(xCounter)
                    gameStatusLabel.text = "X won!"
                }
                
                func proccedNougthWin()
                {
                    oCounter += 1
                    oCounterLabel.text = String(oCounter)
                    gameStatusLabel.text = "O won!"
                }
                
                func proccedDraw()
                {
                    gameStatusLabel.text = "Draw!"
                }
                
                if sign == "Cross"
                {
                    proccedCrossWin()
                }
                
                else if sign == "Nougth"
                {
                    proccedNougthWin()
                }
                
                else if sign == "Draw"
                {
                    proccedDraw()
                }
            }
            
            for gameOverCombination in gameOverCombinations
            {
                if currentCellsState[gameOverCombination[0]] != "Empty" && currentCellsState[gameOverCombination[0]] == currentCellsState[gameOverCombination[1]] && currentCellsState[gameOverCombination[0]] == currentCellsState[gameOverCombination[2]]
                {
                    isGameFinished = true
                    checkWinSign(currentCellsState[gameOverCombination[0]])
                }
            }
            
            if currentCellsState.contains("Empty") {}
            else if !isGameFinished
            {
                isGameFinished = true
                checkWinSign("Draw")
            }
            
        }
        
        gameProcess(sender)
    }
    

    @IBOutlet weak var playAgain: UIButton!
    
    @IBAction func clickedPlayAgain(_ sender: Any)
    {
        func resetEntities()
        {
            currentPlayer = "Cross"
            currentCellsState = ["Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
            isGameFinished = false
            
            playAgain.isHidden = true
            gameStatusLabel.text = ""
            
            for button in buttonsList
            {
                button?.setImage(nil, for: UIControl.State())
            }
        }
        
        resetEntities()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

