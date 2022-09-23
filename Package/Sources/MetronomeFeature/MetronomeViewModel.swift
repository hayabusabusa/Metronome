//
//  MetronomeViewModel.swift
//  
//
//  Created by Shunya Yamada on 2022/09/22.
//

import Audio
import Combine
import Foundation

public final class MetronomeViewModel {

    private let hapticService: HapticService?

    @Published var error: Error?
    @Published var isPlaying = false

    public init(hapticService: HapticService?) {
        self.hapticService = hapticService

        // NOTE: CoreHaptic 関連クラスの初期化に失敗した場合はエラーを流す.
        if hapticService == nil {
            error = NSError(domain: "CoreHapticError", code: -1, userInfo: nil)
        }
    }

    func onPlayButtonPressed() {
        guard let hapticService = hapticService else { return }

        do {
            if isPlaying {
                hapticService.stop()
            } else {
                try hapticService.play()
            }
        } catch {
            self.error = error
        }

        isPlaying = hapticService.isPlaying
    }

    func onIncreaseButtonPressed() {}

    func onDecreaseButtonPressed() {}
}
