//
//  ContentView.swift
//  TicTacToeMultiAIDifficulty
//
//  Created by Afnan Ahmad on 16/05/2024.
//

import SwiftUI


struct GameView: View {
    
    @State private var viewModel = GameViewModel()
    
    
    var body: some View {
        GeometryReader { geometry in
            
            
            VStack {
                Spacer()
                
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            
                            PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                
                Spacer()
            }
            .disabled(viewModel.isGameBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))
            }
        }
    }
    
    
    
}

#Preview {
    GameView()
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



struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        let gWidth = proxy.size.width
        //let gHeight = geometry.size.height
        
        Circle()
            .foregroundStyle(.red.opacity(0.5))
            .frame(width: gWidth / 3 - 15, height: gWidth / 3 - 15)
    }
}



struct PlayerIndicator: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundStyle(.white.opacity(0.9))
    }
}
