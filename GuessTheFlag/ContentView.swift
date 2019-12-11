//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andrew Lawler on 11/12/2019.
//  Copyright © 2019 andrewlawler. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var youWin = ""
    @State private var usersScore = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.blue, lineWidth: 1))
                        
                            .shadow(color: .black, radius: 2)
                        }
                    }
                    Text("Current Score \(usersScore)")
                        .foregroundColor(.white)
                    Text("\(youWin)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Spacer()
                }
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Your score is \(usersScore)"), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int){
        youWin = ""
        if number == correctAnswer {
            scoreTitle = "Correct"
            usersScore += 1
            if usersScore == 10 {
                youWin = "You win!"
                usersScore = 0
            }
        }
        else {
            scoreTitle = "Wrong, that's \(countries[number])"
            if usersScore != 0 {
                usersScore -= 1
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
