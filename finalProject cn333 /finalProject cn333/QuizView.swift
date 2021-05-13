//
//  QuizView.swift
//  finalProject cn333
//
//  Created by Siriluk Rachaniyom on 11/5/2564 BE.
//

import SwiftUI
import Foundation

struct QuizView: View {
    @ObservedObject private var quizManager = QuizModel()
    @State private var guessedCorrectly = false
    @State private var showResult = false
    @State private var textColor = Color.white
    @State var timeRemaining = 10
    let timerTemp = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isActive = true
    
    var body: some View {
        ZStack {
            Color(red: 255.0 / 255.0, green: 215.0 / 255.0, blue:0.0 / 255.0)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(alignment: .top){
                    Text("Time: \(timeRemaining)")
                        .padding()
                        .background(Color(red: 50.0 / 255.0, green: 100.0 / 255.0, blue: 50.0 / 255.0))
                        .foregroundColor(.white)
                        .cornerRadius(8.0)
                        .onReceive(timerTemp) { time in
                            if self.timeRemaining == 0 {
                                self.showResult = true
                            }
                        }
                    Text("Score: \(self.quizManager.correctAnswers)")
                        .padding()
                        .background(Color(red: 147.0 / 255.0, green: 0, blue: 135.0 / 255.0))
                        .foregroundColor(.white)
                        .cornerRadius(8.0)
                    HStack{
                        if(self.quizManager.life == 3){
                            Spacer()
                            Image("heart").resizable().frame(width: 30, height: 30)
                            Image("heart").resizable().frame(width: 30, height: 30)
                            Image("heart").resizable().frame(width: 30, height: 30)
                        }else if(self.quizManager.life == 2){
                            Spacer()
                            Image("heart").resizable().frame(width: 30, height: 30)
                            Image("heart").resizable().frame(width: 30, height: 30)
                        }else if(self.quizManager.life == 1){
                            Spacer()
                            Image("heart").resizable().frame(width: 30, height: 30)
                        }else{}
                    }.padding()
                }//Close HStack
                
                //question text
                Text(quizManager.currentQuestion.question)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .font(.title)
                    .padding()
                
                Spacer()
                
                //image of the question
                Image(quizManager.currentQuestion.img ?? "Estonia")
                    .resizable()
                    .scaledToFit()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .padding()
                
                VStack {
                    //choice for question
                    ForEach(quizManager.currentQuestion.answer) { answer in
                        clickButton(textColor: self.$textColor, answer: answer.text) {
                            self.restartTimer()
                            self.guessedCorrectly = self.quizManager.checkAnswer(answer, to: self.quizManager.currentQuestion)
                            self.updateResult()
                        }
                    }
                    .padding()
                    //time countdown
                    .onReceive(timerTemp) { time in
                        guard self.isActive else { return }
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        }
                    }
                    //เพื่อที่กรณีเผลอกดออกจากแอป เวลาจะไม่นับต่อ จนกว่าจะกลับเข้าแอป
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        self.isActive = false
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        self.isActive = true
                    }
                }//Close VStack
                
                Spacer()
                
                //button for giveup
                Button(action:{
                    self.buttonAction()
                },label: {
                    Text("Surrender")
                        .padding()
                        .background(Color(red: 240.0/255.0, green: 128.0 / 255.0, blue: 128.0 / 255.0))
                        .foregroundColor(.white)
                        .cornerRadius(8.0)
                })
            }
            .padding()
            
        }//Close ZStack
        
        //if showResult has change EndGameView() will popup
        .popover(isPresented: self.$showResult) {
            EndGameView(isPresented: self.$showResult, score: self.quizManager.correctAnswers)
                .onDisappear {
                    self.resetGame()
                }
        }
        .onAppear {
            Sound.playGameStartSound()
        }
    }// Close body

    func restartTimer(){
      timeRemaining = 10
    }
    
    //Function for restart game
    func resetGame() {
        quizManager.questionsAsked = 0
        quizManager.correctAnswers = 0
        quizManager.life = 3
        textColor = .white
        quizManager.getRandomQuestion()
        timeRemaining = 10
    }
    
    //Function to check answer and check condition for endgame
    private func updateResult() {
        if guessedCorrectly {
            Sound.playRightAnswerSound()
        } else {
            Sound.playWrongAnswerSound()
        }
        textColor = guessedCorrectly ? .green : .red
        if quizManager.questionsAsked == 10 || self.quizManager.life == 0 || timeRemaining == 0{
            self.showResult.toggle()
        } else {
            loadNextRoundWithDelay(seconds: 0.1)
        }
    }
    
    //Function to load next question
    private func loadNextRoundWithDelay(seconds: Double) {
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.textColor = .white
            self.quizManager.getRandomQuestion()
        }
    }
    //Function for button surrender
    private func buttonAction() {
        self.showResult.toggle()
        Sound.playWrongAnswerSound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
