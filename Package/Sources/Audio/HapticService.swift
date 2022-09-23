//
//  HapticService.swift
//  
//
//  Created by Shunya Yamada on 2022/09/19.
//

import AVFoundation
import CoreHaptics
import Foundation
import UIKit

public final class HapticService {
    private let audioSessionService = AudioSessionService.shared

    private let hapticEngine: CHHapticEngine
    private var player: CHHapticAdvancedPatternPlayer?

    public let beats: BeatServiceProtocol = BeatService(bpm: 120)
    private(set) public var isPlaying = false

    public init() throws {
        try audioSessionService.activate()

        hapticEngine = try CHHapticEngine(audioSession: audioSessionService.session)
        hapticEngine.resetHandler = { [weak self] in
            try? self?.hapticEngine.start()
        }
        hapticEngine.stoppedHandler = { reason in
            print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
        }
        try hapticEngine.start()
        try configurePlayer()
        
        configureObserver()
    }

    public func play() throws {
        try player?.start(atTime: CHHapticTimeImmediate)
        isPlaying = true
    }

    public func stop() throws {
        try player?.stop(atTime: CHHapticTimeImmediate)
        isPlaying = false
    }

    public func change(bpm: Double) throws {
        // NOTE: BPM を変えて Player を生成し直す.
        // Player の生成し直しはそこまでコストが高くない.
        // https://developer.apple.com/documentation/corehaptics/updating_continuous_and_transient_haptic_parameters_in_real_time
        beats.change(bpm: bpm)
        try configurePlayer()

        if isPlaying {
            try play()
        }
    }
}

private extension HapticService {
    func configurePlayer() throws {
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

    func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
    }

    @objc func willEnterForeground() {
        try? hapticEngine.start()

        if isPlaying {
            try? player?.start(atTime: CHHapticTimeImmediate)
        }
    }

    @objc func didEnterBackground() {
        hapticEngine.stop()
    }
}
