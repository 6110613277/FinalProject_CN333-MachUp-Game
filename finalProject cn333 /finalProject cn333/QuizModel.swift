//
//  QuizModel.swift
//  finalProject cn333
//
//  Created by Siriluk Rachaniyom on 11/5/2564 BE.
//

import GameKit
import Combine

final class QuizModel: ObservableObject {
    @Published var currentQuestion = Question(img: "", question: "", answer: [], correctAnswer: Answer(text: ""))
    private var questionsUsed = [Question]() 
    var questionsAsked = 0
    var correctAnswers = 0
    var life = 3
    
    //Arrays for questions and answers
    private var questions = [
        Question(img: "Estonia", question: "What is correct answer?", answer: [Answer(text: "Estonia"), Answer(text: "Angola"), Answer(text: "Barbados"), Answer(text: "Malaysia")].shuffled(), correctAnswer: Answer(text: "Estonia")),
        
        Question(img: "France", question: "What is correct answer?", answer: [Answer(text: "Italy"), Answer(text: "Brazil"), Answer(text: "France"), Answer(text: "Denmark")].shuffled(), correctAnswer: Answer(text: "France")),
        
        Question(img: "Germany", question: "What is correct answer?", answer: [Answer(text: "Australia"), Answer(text: "Italy"), Answer(text: "Hungary"), Answer(text: "Germany")].shuffled(), correctAnswer: Answer(text: "Germany")),
        
        Question(img: "Ireland", question: "What is correct answer?", answer: [Answer(text: "Jordan"), Answer(text: "Ireland"), Answer(text: "Angola"), Answer(text: "Bolivia")].shuffled(), correctAnswer: Answer(text: "Ireland")),
        
        Question(img: "Italy", question: "What is correct answer?", answer: [Answer(text: "Estonia"), Answer(text: "Barbados"), Answer(text: "Brazil"), Answer(text: "Italy")].shuffled(), correctAnswer: Answer(text: "Italy")),
        
        Question(img: "Monaco", question: "What is correct answer?", answer: [Answer(text: "Cameroon"), Answer(text: "Monaco"), Answer(text: "Brazil"), Answer(text: "Nigeria")].shuffled(), correctAnswer: Answer(text: "Monaco")),
        
        Question(img: "Nigeria", question: "What is correct answer?", answer: [Answer(text: "Nigeria"), Answer(text: "Malaysia"), Answer(text: "Bolivia"), Answer(text: "Hungary")].shuffled(), correctAnswer: Answer(text: "Nigeria")),
                
        Question(img: "Russia", question: "What is correct answer?", answer: [Answer(text: "Denmark"), Answer(text: "Monaco"), Answer(text: "Angola"), Answer(text: "Russia")].shuffled(), correctAnswer: Answer(text: "Russia")),
                
        Question(img: "Spain", question: "What is correct answer?", answer: [Answer(text: "Germany"), Answer(text: "Ireland"), Answer(text: "Spain"), Answer(text: "Italy")].shuffled(), correctAnswer: Answer(text: "Spain")),
        
        Question(img: "UK", question: "What is correct answer?", answer: [Answer(text: "UK"), Answer(text: "US"), Answer(text: "France"), Answer(text: "Jordan")].shuffled(), correctAnswer: Answer(text: "UK")),
        
        Question(img: "US", question: "What is correct answer?", answer: [Answer(text: "UK"), Answer(text: "US"), Answer(text: "Italy"), Answer(text: "Denmark")].shuffled(), correctAnswer: Answer(text: "US")),
    ].shuffled()
    
    init() {
        getRandomQuestion()
    }
    
    //Function which returns a random question and checks if the question has been asked before
    func getRandomQuestion() {
        guard var randomQuestion = questions.shuffled().first else { return }
        
        if questionsUsed.isEmpty || !questionsUsed.contains(randomQuestion) {
            questionsUsed.append(randomQuestion)
            currentQuestion = randomQuestion
        } else {
            for question in questionsUsed {
                while randomQuestion == question {
                    randomQuestion = questions.shuffled().first!
                    questionsUsed.append(randomQuestion)
                    currentQuestion = randomQuestion
                }
            }
        }
    }
    
    //Function to check answer that user choose
    func checkAnswer(_ answer: Answer, to question: Question) -> Bool {
        questionsAsked += 1
        
        if answer.text == question.correctAnswer.text {
            correctAnswers += 5
        }else{
            life -= 1
        }
        
        return answer.text == question.correctAnswer.text
    }
    
    //Function to save last score
    func SaveScore(quiz : String , score : Int){
        UserDefaults.standard.set(score, forKey: quiz)
    }
    
    //Function to load last score
    func LoadScore (quiz : String) -> Int{
        return UserDefaults.standard.integer(forKey: quiz)
    }
}

struct Question : Equatable{
    var id: String = UUID().uuidString
    var img : String?
    var question : String //คำถาม
    var answer : [Answer] //ช้อยคำตอบ
    var correctAnswer: Answer //คำตอบที่ถูกต้อง
}

struct Answer: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var text: String
}
