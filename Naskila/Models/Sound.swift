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
    
    // Локальное хранение настроек для уменьшения связности
    private var isMusicEnabled = false
    private var isSoundEnabled = false
    
    private init() {
        setupBackgroundMusic()
        setupNotifications()
        
        // Инициализируем локальные настройки
        isMusicEnabled = GameSettings.shared.musicEnabled
        isSoundEnabled = GameSettings.shared.soundEnabled
        
        // Применяем начальные настройки
        if isMusicEnabled {
            playBackgroundMusic()
        }
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
    
    private func setupNotifications() {
        // Подписываемся на уведомления об изменении настроек
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSoundSettingChanged(_:)),
            name: .soundSettingChanged,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMusicSettingChanged(_:)),
            name: .musicSettingChanged,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSettingsLoaded),
            name: .settingsLoaded,
            object: nil
        )
    }
    
    // MARK: - Notification handlers
    
    @objc private func handleSoundSettingChanged(_ notification: Notification) {
        if let isEnabled = notification.object as? Bool {
            isSoundEnabled = isEnabled
        }
    }
    
    @objc private func handleMusicSettingChanged(_ notification: Notification) {
        if let isEnabled = notification.object as? Bool {
            isMusicEnabled = isEnabled
            
            if isEnabled {
                playBackgroundMusic()
            } else {
                stopBackgroundMusic()
            }
        }
    }
    
    @objc private func handleSettingsLoaded() {
        // Синхронизируем локальные настройки с глобальными
        isMusicEnabled = GameSettings.shared.musicEnabled
        isSoundEnabled = GameSettings.shared.soundEnabled
        
        // Применяем настройки
        if isMusicEnabled {
            playBackgroundMusic()
        } else {
            stopBackgroundMusic()
        }
    }
    
    // MARK: - Public methods
    
    func playBackgroundMusic() {
        // Проверяем локальную настройку и готовность плеера
        guard isMusicEnabled && isBackgroundMusicPrepared else { return }
        
        // Проверяем, не воспроизводится ли музыка уже
        if let player = backgroundMusicPlayer, !player.isPlaying {
            player.play()
        }
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    func playSound(named soundName: String = "sound") {
        // Проверяем локальную настройку
        guard isSoundEnabled else { return }
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
            soundEffectPlayer?.numberOfLoops = 0
            soundEffectPlayer?.play()
        } catch {
            print("Could not play sound: \(error.localizedDescription)")
        }
    }
    
    // Упрощенные методы для обработки состояний приложения
    func handleAppBackground() {
        stopBackgroundMusic()
    }
    
    func handleAppForeground() {
        if isMusicEnabled {
            playBackgroundMusic()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
