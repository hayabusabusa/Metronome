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
    private let audioSession: AVAudioSession
    private let hapticEngine: CHHapticEngine
    private var player: CHHapticAdvancedPatternPlayer?

    public let beats: BeatServiceProtocol = BeatService(bpm: 120)
    private(set) public var isPlaying = false

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
        do {
            if player == nil {
                guard let url = AudioFileService.resource(for: .click) else { return }

                let audioResourceID = try hapticEngine.registerAudioResource(url)
                let hapticEvents = [
                    CHHapticEvent(audioResourceID: audioResourceID,
                                  parameters: [
                                    .init(parameterID: .audioVolume, value: 1.0),
                                  ],
                                  relativeTime: 0,
                                  duration: beats.intervalForBPM),
                ]
                let pattern = try CHHapticPattern(events: hapticEvents, parameters: [])

                player = try hapticEngine.makeAdvancedPlayer(with: pattern)
                player?.loopEnabled = true
            }

            try player?.start(atTime: CHHapticTimeImmediate)

            isPlaying = true
        } catch {
            throw error
        }
    }

    public func stop() {
        try? player?.stop(atTime: CHHapticTimeImmediate)
        isPlaying = false
    }
}
