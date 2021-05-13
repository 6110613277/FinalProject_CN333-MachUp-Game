//
//  QuizModel2.swift
//  finalProject cn333
//
//  Created by Siriluk Rachaniyom on 12/5/2564 BE.
//

import GameKit
import Combine

final class QuizModel2: ObservableObject {
    @Published var currentQuestion = Question(img: "", question: "", answer: [], correctAnswer: Answer(text: ""))
    private var questionsUsed = [Question]()
    var questionsAsked = 0
    var correctAnswers = 0
    var life = 3
    
    
    //Arrays for questions and answers
    private var questions = [
        Question(img: "cat", question: "What is correct answer?", answer: [Answer(text: "Deer"), Answer(text: "Dog"), Answer(text: "Tiger"), Answer(text: "Cat")].shuffled(), correctAnswer: Answer(text: "Cat")),
        
        Question(img: "dog", question: "What is correct answer?", answer: [Answer(text: "Dog"), Answer(text: "Rabbit"), Answer(text: "Cat"), Answer(text: "Monkey")].shuffled(), correctAnswer: Answer(text: "Dog")),
        
        Question(img: "deer", question: "What is correct answer?", answer: [Answer(text: "Kangaroo"), Answer(text: "Lion"), Answer(text: "Bird"), Answer(text: "Deer")].shuffled(), correctAnswer: Answer(text: "Deer")),
        
        Question(img: "owl", question: "What is correct answer?", answer: [Answer(text: "Hoornbill"), Answer(text: "Owl"), Answer(text: "Rabbit"), Answer(text: "Zebra")].shuffled(), correctAnswer: Answer(text: "Owl")),
        
        Question(img: "chameleon", question: "What is correct answer?", answer: [Answer(text: "Baboon"), Answer(text: "Cat"), Answer(text: "Dog"), Answer(text: "Chameleon")].shuffled(), correctAnswer: Answer(text: "Chameleon")),
        
        Question(img: "alpaca", question: "What is correct answer?", answer: [Answer(text: "Sheep"), Answer(text: "Goat"), Answer(text: "Duck"), Answer(text: "Chameleon")].shuffled(), correctAnswer: Answer(text: "Alpaca")),
        
        Question(img: "hornbill", question: "What is correct answer?", answer: [Answer(text: "Alpaca"), Answer(text: "Owl"), Answer(text: "Cat"), Answer(text: "Hornbill")].shuffled(), correctAnswer: Answer(text: "Hornbill")),
        
        Question(img: "koala", question: "What is correct answer?", answer: [Answer(text: "Monkey"), Answer(text: "Bird"), Answer(text: "Koala"), Answer(text: "Dog")].shuffled(), correctAnswer: Answer(text: "Koala")),
        
        Question(img: "crowned hornbill", question: "What is correct answer?", answer: [Answer(text: "Crowned hornbill"), Answer(text: "Sheep"), Answer(text: "Rabbit"), Answer(text: "Koala")].shuffled(), correctAnswer: Answer(text: "Crowned hornbill")),
        
        Question(img: "baboon", question: "What is correct answer?", answer: [Answer(text: "Lion"), Answer(text: "BaBoon"), Answer(text: "Goat"), Answer(text: "Tiger")].shuffled(), correctAnswer: Answer(text: "Baboon")),
    ]
    
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
    func checkAnswer2(_ answer: Answer, to question: Question) -> Bool {
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
}//Close QuizModel2

