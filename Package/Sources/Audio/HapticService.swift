//
//  HapticService.swift
//  
//
//  Created by Shunya Yamada on 2022/09/19.
//

import AVFoundation
import CoreHaptics
import Foundation

public final class HapticService {
    private let bpm: CGFloat = 120.0
    private let audioSession: AVAudioSession
    private let hapticEngine: CHHapticEngine
    private var player: CHHapticAdvancedPatternPlayer?

    private var audioDuration: TimeInterval {
        TimeInterval(60.0 / bpm)
    }

    public init() throws {
        do {
            audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true)

            hapticEngine = try CHHapticEngine(audioSession: audioSession)
            hapticEngine.resetHandler = { [weak self] in
                try? self?.hapticEngine.start()
            }
            hapticEngine.stoppedHandler = { reason in
                print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
            }
            try hapticEngine.start()
        } catch {
            throw error
        }
    }

    public func play() throws {
        guard let url = AudioFileService.resource(for: .click) else { return }

        do {
            let audioResourceID = try hapticEngine.registerAudioResource(url)
            let hapticEvents = [
                CHHapticEvent(audioResourceID: audioResourceID,
                              parameters: [
                                .init(parameterID: .audioVolume, value: 1.0),
                              ],
                              relativeTime: 0,
                              duration: audioDuration),
                CHHapticEvent(eventType: .hapticTransient,
                              parameters: [
                                .init(parameterID: .hapticSharpness, value: 0.4),
                                .init(parameterID: .hapticIntensity, value: 1.0)
                              ],
                              relativeTime: 0),
                CHHapticEvent(eventType: .hapticContinuous,
                              parameters: [
                                .init(parameterID: .hapticSharpness, value: 0.4),
                                .init(parameterID: .hapticIntensity, value: 1.0)
                              ],
                              relativeTime: 0,
                              duration: 0.08)
            ]
            let pattern = try CHHapticPattern(events: hapticEvents, parameters: [])

            player = try hapticEngine.makeAdvancedPlayer(with: pattern)
            player?.loopEnabled = true

            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            throw error
        }
    }

    public func stop() {
        hapticEngine.stop(completionHandler: nil)
    }
}
