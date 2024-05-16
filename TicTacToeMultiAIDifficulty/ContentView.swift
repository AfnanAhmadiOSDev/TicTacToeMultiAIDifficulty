//
//  ContentView.swift
//  TicTacToeMultiAIDifficulty
//
//  Created by Afnan Ahmad on 16/05/2024.
//

import SwiftUI


struct ContentView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isHumansTurn = true
    
    var body: some View {
        GeometryReader { geometry in
            let gWidth = geometry.size.width
            //let gHeight = geometry.size.height
            
            VStack {
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundStyle(.red.opacity(0.5))
                                .frame(width: gWidth / 3 - 15, height: gWidth / 3 - 15)
                            
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.white.opacity(0.9))
                        }
                        .onTapGesture {
                            //if moves[i] != nil {return} //why didn't he do this ??
                            if isSquareOccupied(in: moves, forIndex: i) { return print("square already marked") }
                            moves[i] = .init(player: isHumansTurn ? .human : .computer, boardIndex: i)
                            isHumansTurn.toggle()
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }//end method
}

#Preview {
    ContentView()
}




enum Player {
    case human, computer
}


struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
