//
//  Sound.swift
//  finalProject cn333
//
//  Created by Siriluk Rachaniyom on 11/5/2564 BE.
//

import AudioToolbox

struct Sound {

    //MARK: - System Sounds
    private static let gameStartSound: SystemSoundID = {
        let pathToSoundFile = Bundle.main.url(forResource: "GameSound", withExtension: "wav")!
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(pathToSoundFile as CFURL, &soundID)
        return soundID
    }()
    
    private static let rightSound: SystemSoundID = {
        let pathToSoundFile = Bundle.main.url(forResource: "RightSound", withExtension: "wav")!
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(pathToSoundFile as CFURL, &soundID)
        return soundID
    }()
    
    private static let wrongSound: SystemSoundID = {
        let pathToSoundFile = Bundle.main.url(forResource: "WrongSound", withExtension: "wav")!
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(pathToSoundFile as CFURL, &soundID)
        return soundID
    }()
    
    private static let timeUpSound: SystemSoundID = {
        let pathToSoundFile = Bundle.main.url(forResource: "TimeUpSound", withExtension: "wav")!
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(pathToSoundFile as CFURL, &soundID)
        return soundID
    }()
    
    //MARK: - Private initializer
    private init() {}
    
    //MARK: - Play sound functions
    static func playGameStartSound() {
        AudioServicesPlaySystemSound(gameStartSound)
    }
    
    static func playRightAnswerSound() {
        AudioServicesPlaySystemSound(rightSound)
    }
    
    static func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
    
    static func playTimeUpSound() {
        AudioServicesPlaySystemSound(timeUpSound)
    }
}

