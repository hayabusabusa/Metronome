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
            try configurePlayer()
        } catch {
            throw error
        }
    }

    public func play() throws {
        do {
            try player?.start(atTime: CHHapticTimeImmediate)
            isPlaying = true
        } catch {
            throw error
        }
    }

    public func stop() throws {
        do {
            try player?.stop(atTime: CHHapticTimeImmediate)
            isPlaying = false
        } catch {
            throw error
        }
    }

    public func change(bpm: Double) throws {
        do {
            // NOTE: BPM を変えて Player を生成し直す.
            // Player の生成し直しはそこまでコストが高くない.
            // https://developer.apple.com/documentation/corehaptics/updating_continuous_and_transient_haptic_parameters_in_real_time
            beats.change(bpm: bpm)
            try configurePlayer()

            if isPlaying {
                try play()
            }
        } catch {
            throw error
        }
    }
}

private extension HapticService {
    func configurePlayer() throws {
        do {
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
        } catch {
            throw error
        }
    }
}
