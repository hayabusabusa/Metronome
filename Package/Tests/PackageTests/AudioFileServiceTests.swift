//
//  AudioFileServiceTests.swift
//  
//
//  Created by Shunya Yamada on 2022/09/19.
//

import XCTest

@testable import Audio

final class AudioFileServiceTests: XCTestCase {
    func test_リソースファイルの確認() {
        XCTContext.runActivity(named: "モジュールに追加した音声ファイルが読み込めること") { _ in
            let url = AudioFileService.resource(for: .click)
            XCTAssertNotNil(url)
        }

        XCTContext.runActivity(named: "モジュールに追加していないファイルは読み込めないこと") { _ in
            let url = AudioFileService.resource(for: "test", of: "mp3")
            XCTAssertNil(url)
        }
    }
}
