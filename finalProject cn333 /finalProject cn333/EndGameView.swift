//
//  EndGameView.swift
//  finalProject cn333
//
//  Created by Siriluk Rachaniyom on 11/5/2564 BE.
//

import SwiftUI

struct EndGameView: View {
    @Binding var isPresented: Bool
    @State private var showHome = false
    @State var score: Int
    @ObservedObject private var quizManager = QuizModel()
    var body: some View {
        ZStack {
            Color(red: 255.0 / 255.0, green: 215.0 / 255.0, blue:0.0 / 255.0)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Spacer()
                    Text("Score").fontWeight(.bold)
                        .font(.system(.title, design: .rounded))
                    Text("\(score)/50")
                        .fontWeight(.bold)
                            .font(.system(.title, design: .rounded))
                        //save score
                        .onAppear(){
                            quizManager.SaveScore(quiz: "questions", score: self.score)
                        }
                    Text("correct").fontWeight(.bold)
                        .font(.system(.title, design: .rounded))
                }//Close VStack
                .font(.title)
                .padding()
                .foregroundColor(.black)
                
                Button(action:{
                    self.buttonAction()
                },label: {
                    Image("newgame").resizable().scaledToFit().frame(width:250, height: 250)
                })
                .padding(.bottom, -50)
                Button(action:{
                    self.buttonAction2()
                },label: {
                    Image("home").resizable().scaledToFit().frame(width:250, height: 250)
                    
                })
            }//Close VStack
            .padding()
        }//Close ZStack
        .popover(isPresented: self.$showHome) {
            HomeView()
        }
        
    }//Close body
    
    //Function to restart game
    private func buttonAction() {
        self.isPresented = false
        Sound.playGameStartSound()
    }
    
    //Function to Home game
    private func buttonAction2() {
        self.showHome = true
        Sound.playGameStartSound()
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView(isPresented: .constant(true), score: 0)
    }
}
