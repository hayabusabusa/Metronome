//
//  AudioRecordService.swift
//  
//
//  Created by Shunya Yamada on 2022/09/23.
//

import AVFoundation
import Foundation

public final class AudioRecordService {
    private let sessionService = AudioSessionService.shared
    private let fileService = AudioFileService()

    private(set) public var recorder: AVAudioRecorder?

    public init() {
        try? sessionService.activate()

        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue,
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey: 44100
        ]
        recorder = try? AVAudioRecorder(url: fileService.fileURL(with: "recording.m4a"),
                                        settings: settings)
        recorder?.isMeteringEnabled = true
        recorder?.prepareToRecord()
    }

    public func requestPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            sessionService.session.requestRecordPermission { response in
                continuation.resume(returning: response)
            }
        }
    }

    public func amplitude() -> Float {
        recorder?.updateMeters()
        let decibel = recorder?.averagePower(forChannel: 0) ?? 0
        let amp = pow(10, decibel / 20)
        return max(0, min(amp, 1))
    }
}
