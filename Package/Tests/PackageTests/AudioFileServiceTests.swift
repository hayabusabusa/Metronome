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

        XCTContext.runActivity(named: "モジュールに追加したリソースを全て読み込めること") { _ in
            let resources = AudioFileService.Resource.allCases.map { AudioFileService.resource(for: $0) }
            XCTAssertFalse(resources.contains(nil))
        }
    }

    func test_ファイル操作の確認() {
        let fileService = AudioFileService(name: "test")

        XCTContext.runActivity(named: "ファイル名付きのパスを正しく返すこと") { _ in
            let expected = "test/test.txt"
            XCTAssertTrue(fileService.fileURL(with: "test.txt").absoluteString.contains(expected))
        }
    }
}
