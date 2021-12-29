//
//  RockPaperScissorsView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Max Gladkov on 29.12.2021.
//

import SwiftUI

struct RockPaperScissorsView: View {
    @State private var moves: [Moves] = [ .rock, .paper, .scissors]
    @State private var userShouldWin = Bool.random()
    @State private var userBeatComputerMove = false
    @State private var userWon = false
    @State private var score = 0
    @State private var scoreTitle = "Wrong"
    @State private var currentMove = Int.random(in: 0...2)
    @State private var showRoundAlert = false
    @State private var showEndAlert = false
    @State private var numberOfRounds = 0
    
   
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                Text("Current score: \(score)" )
            }
            Spacer()
            ConditionText(userShouldWin: userShouldWin, currentMove: moves[currentMove])
            Spacer()
            VStack {
                ForEach(moves, id: \.self) { move in
                    MoveButton(type: move) {
                        moveChosen(move: move)
                        matchWon()
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showRoundAlert) {
            Button("Continue") {
                nextTurn()
            }
        }
        .alert("End of Game", isPresented: $showEndAlert) {
            Button("New game") {
                score = 0
                numberOfRounds = 0
                nextTurn()
            }
        } message: {
            Text("Number of rounds is exceeded \nYour score is: \(score)")
        }
        
    }
    
    //MARK: func
    
    func nextTurn() {
        currentMove = Int.random(in: 0...2)
        userShouldWin = Bool.random()
        scoreTitle = "Wrong"
    }
    
    func matchWon() {
        if userShouldWin == userBeatComputerMove {
            scoreTitle = "Correct"
            score += 1
            userWon = true
        }
        numberOfRounds += 1
        if numberOfRounds == 10 {
            showEndAlert = true
        } else {
            showRoundAlert = true
        }
    }
    
    func moveChosen(move: Moves) {
        let currentMove = moves[currentMove]
        let userMove = move

        switch currentMove {
        case .rock:
            switch userMove {
            case .rock:
                userBeatComputerMove = false
            case .paper:
                userBeatComputerMove = true
            case .scissors:
                userBeatComputerMove = false
            }
            
        case .paper:
            switch userMove {
            case .rock:
                userBeatComputerMove = false
            case .paper:
                userBeatComputerMove = false
            case .scissors:
                userBeatComputerMove = true
            }
            
        case .scissors:
            switch userMove {
            case .rock:
                userBeatComputerMove = true
            case .paper:
                userBeatComputerMove = false
            case .scissors:
                userBeatComputerMove = false
            }
        }
    }
    
    //MARK: Custom Views
    
    struct ConditionText: View {
        var userShouldWin: Bool
        var currentMove: Moves
        
        var body: some View {
            VStack {
                Text("Choose a move to ")
                Text(userShouldWin ? "win" : "lose")
                    .foregroundColor(userShouldWin ? .green : .red)
                Text("against")
                Text(currentMove.rawValue)
            }
            .font(.largeTitle)
            
        }
    }
    
    struct MoveButton: View {
        var type: Moves
        var action: () -> ()
        
        var body: some View {
            Button() {
                action()
            } label: {
                Text(type.rawValue)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .frame(minWidth: 150, minHeight: 50)
                    .padding()
                    .background(.blue)
                    .clipShape(Capsule())
            }
        }
    }
}



enum Moves: String {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}

struct RockPaperScissorsView_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissorsView()
    }
}
