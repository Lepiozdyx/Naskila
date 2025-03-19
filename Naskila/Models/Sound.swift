//
//  Sound.swift
//  Naskila
//
//  Created by Alex on 19.03.2025.
//

import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var soundEffectPlayer: AVAudioPlayer?
    private var isBackgroundMusicPrepared = false
    
    // Флаги для предотвращения рекурсивных вызовов
    private var isPlayingMusic = false
    private var isPlayingSound = false
    
    private init() {
        setupBackgroundMusic()
    }
    
    // MARK: - Setup methods
    
    private func setupBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else {
            print("Background music file not found")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.prepareToPlay()
            isBackgroundMusicPrepared = true
        } catch {
            print("Could not load background music: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Public methods
    
    func playBackgroundMusic() {
        // Предотвращаем рекурсивный вызов
        guard !isPlayingMusic else { return }
        isPlayingMusic = true
        
        // Проверяем, включена ли музыка в настройках, но не обращаемся к методам, которые могут изменить настройки
        if GameSettings.shared.musicEnabled && isBackgroundMusicPrepared {
            // Проверяем, не воспроизводится ли музыка уже
            if let player = backgroundMusicPlayer, !player.isPlaying {
                player.play()
            }
        }
        
        isPlayingMusic = false
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    func playSound(named soundName: String = "sound") {
        // Предотвращаем рекурсивный вызов
        guard !isPlayingSound else { return }
        isPlayingSound = true
        
        // Проверяем, включен ли звук в настройках, но не обращаемся к методам, которые могут изменить настройки
        guard GameSettings.shared.soundEnabled else {
            isPlayingSound = false
            return
        }
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file not found")
            isPlayingSound = false
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
            soundEffectPlayer?.numberOfLoops = 0
            soundEffectPlayer?.play()
        } catch {
            print("Could not play sound: \(error.localizedDescription)")
        }
        
        isPlayingSound = false
    }
    
    // Упрощенные методы для обработки состояний приложения
    func handleAppBackground() {
        stopBackgroundMusic()
    }
    
    func handleAppForeground() {
        if GameSettings.shared.musicEnabled {
            playBackgroundMusic()
        }
    }
}
