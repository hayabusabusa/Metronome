//
//  BeatService.swift
//  
//
//  Created by Shunya Yamada on 2022/09/22.
//

import Foundation

public protocol BeatServiceProtocol {
    /// BPM( Beats per minute ).
    var bpm: Double { get }
    /// BPM から算出した `TimeInterval`.
    var intervalForBPM: TimeInterval { get }
    /// BPM を変更する.
    func change(bpm: Double)
}

public final class BeatService: BeatServiceProtocol {
    private(set) public var bpm: Double

    public var intervalForBPM: TimeInterval {
        60.0 / bpm
    }

    public init(bpm: Double) {
        self.bpm = bpm
    }

    public func change(bpm: Double) {
        self.bpm = bpm
    }
}
