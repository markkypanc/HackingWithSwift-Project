//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mark Rachapoom on 20/2/21.
//

import SwiftUI

extension Color {
    static let dropShadow = Color(hex: "aeaec0").opacity(0.6)
    static let dropLight = Color(hex: "ffffff")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "USA"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var scoreCount = 0
    
    
    var body: some View {
        
        ZStack {
            
            Color(.white)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 30) {
                
                VStack {
                    Text("Tap the flag of")
                        .font(.title)
                    Text(countries[correctAnswer])
                        .font(.system(size: 20))
                }
                .foregroundColor(.black)
                
                ForEach(0..<3) { number in
                    Button(action: {
                        // Action when button got pressed
                        self.flagTapped(number)
                    }, label: {
                        Image(self.countries[number])
                            .resizable()
                    })
                    .cornerRadius(18)
                    .shadow(color: .dropShadow, radius: 15, x: 10, y: 10)
                    .shadow(color: .dropLight, radius: 15, x: -10, y: -10)
                    .alert(isPresented: $showingScore) {
                        Alert(title: Text(scoreTitle),
                              message: Text("Your score is \(scoreCount)"),
                              dismissButton: .default(Text("Continue")) {
                            self.askQuestion()
                        })
                    }
                }
            }
            .padding(.all, 70)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCount += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
