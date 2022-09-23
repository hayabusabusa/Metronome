//
//  AudioSessionService.swift
//  
//
//  Created by Shunya Yamada on 2022/09/23.
//

import AVFoundation
import Foundation

public final class AudioSessionService {
    public static let shared: AudioSessionService = .init()

    public let session: AVAudioSession

    private init() {
        session = AVAudioSession.sharedInstance()
    }

    public func activate() throws {
        guard session.category == .playAndRecord else { return }

        try session.setActive(true, options: [])
        try session.setCategory(.playAndRecord)
    }
}
