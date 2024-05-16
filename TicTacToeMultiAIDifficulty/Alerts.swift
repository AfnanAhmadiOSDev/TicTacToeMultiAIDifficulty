//
//  Alerts.swift
//  TicTacToeMultiAIDifficulty
//
//  Created by Afnan Ahmad on 16/05/2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}


struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win!"), 
                                    message: Text("You are so smart !!!"),
                                    buttonTitle: Text("Hell Yeah"))
    
    static let computerWin = AlertItem(title: Text("You LOSE!"),
                                    message: Text("You created a smart AI !!!"),
                                    buttonTitle: Text("Rematch!"))
    
    static let draw = AlertItem(title: Text("Draw"),
                                    message: Text("meh !"),
                                    buttonTitle: Text("Try again ?"))
}
