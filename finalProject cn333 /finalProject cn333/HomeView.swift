//
//  HomeView.swift
//  finalProject cn333
//
//  Created by Siriluk Rachaniyom on 11/5/2564 BE.
//

import SwiftUI
 
//first view of the app
struct HomeView: View {
    @ObservedObject private var quizManager = QuizModel()
    @State private var showCategory = false
    @State private var showCategory2 = false
    @State var numCategory = "0"
    @State var correctAnswers = 0

    var body: some View {
        ZStack {
            Color(red: 255.0 / 255.0, green: 215.0 / 255.0, blue:0.0 / 255.0).edgesIgnoringSafeArea(.all)
            
            VStack {
                //image of the logo game
                Image("matchup").resizable().scaledToFit().frame(width: 300, height: 300)
                
                Text("last score : \(correctAnswers) /50").fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
                    //refresh score
                    .onAppear(){
                        correctAnswers = quizManager.LoadScore(quiz: "questions")
                    }
                    .foregroundColor(.black)
                //image of the category
                Image("category").resizable().frame(width: 200, height: 200)
                
                //Button to choose category of Flags
                Button(action:{
                    self.buttonAction()
                },label: {
                    Text("Flags")
                        .padding()
                        .background(Color(red: 160.0/255.0, green: 82.0 / 255.0, blue: 45.0 / 255.0))
                        .foregroundColor(.white)
                        .cornerRadius(8.0)
                })
                
                //Button to choose category of Animals
                Button(action:{
                    self.buttonAction2()
                },label: {
                    Text("Animals")
                        .padding()
                        .background(Color(red: 160.0/255.0, green: 82.0 / 255.0, blue: 45.0 / 255.0))
                        .foregroundColor(.white)
                        .cornerRadius(8.0)
                })
            }//Close VStack
            .padding()
        }
        .popover(isPresented: self.$showCategory) {
            QuizView()
        }
        .sheet(isPresented: self.$showCategory2) {
            QuizView2()
        }
       
        
    }
    //Function to Flags popup
    private func buttonAction() {
        self.showCategory.toggle()

    }
    
    //Function to Animals popup
    private func buttonAction2() {
        self.showCategory2.toggle()

    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
