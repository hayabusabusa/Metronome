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
}

public struct BeatService: BeatServiceProtocol {
    public let bpm: Double

    public var intervalForBPM: TimeInterval {
        60.0 / bpm
    }

    public init(bpm: Double) {
        self.bpm = bpm
    }
}
