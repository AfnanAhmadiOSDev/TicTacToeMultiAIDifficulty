//
//  GameViewModel.swift
//  TicTacToeMultiAIDifficulty
//
//  Created by Afnan Ahmad on 16/05/2024.
//

import SwiftUI


@Observable
final class GameViewModel {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var moves: [Move?] = Array(repeating: nil, count: 9)
    var isGameBoardDisabled = false
    var alertItem: AlertItem?
    
    
    func processPlayerMove(for position: Int) {
        //if moves[i] != nil {return} //why didn't he do this ??
        if isSquareOccupied(in: moves, forIndex: position) { return print("square already marked") }
        moves[position] = .init(player: .human, boardIndex: position)
        
        //check for win condition
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return print("human wins")
        }
        
        //check for draw
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return print("draw")
        }
        
        isGameBoardDisabled = true
        //moves[i] = .init(player: isHumansTurn ? .human : .computer, boardIndex: i)
        //isHumansTurn.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = .init(player: .computer, boardIndex: position)
            isGameBoardDisabled = false
            
            //check for win condition
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                return print("computer wins")
            }
            
            //check for draw
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return print("draw")
            }
        }
    }//end method
    
    
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }//end method
    
    
    //If AI can win, then win
    //if Ai can't win, then block
    //if Ai can't block, then take middle square
    //if Ai can't take middle, take random available square
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        //If AI can win, then win
        let computerMoves = moves.compactMap {$0}.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        
        //if Ai can't win, then block
        let humanMoves = moves.compactMap {$0}.filter { $0.player == .human }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        
        //if Ai can't block, then take middle square
        let middleSquare = 4
        if !isSquareOccupied(in: moves, forIndex: middleSquare) {
            return middleSquare
        }
        
        
        //if Ai can't take middle, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }//end method
    
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap {$0}.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions){
            return true
        }
        
        return false
    }//end method
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.map { $0 }.count == 9
    }//end method
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }//end method
    
}//end class
