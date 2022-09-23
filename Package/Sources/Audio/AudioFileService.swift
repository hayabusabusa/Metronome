//
//  AudioFileService.swift
//  
//
//  Created by Shunya Yamada on 2022/09/19.
//

import Foundation

public struct AudioFileService {
    private let path: URL

    public init(name: String = "jp.shunya.yamada.metronome.AudioFileService") {
        guard let root = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("\(NSError(domain: NSCocoaErrorDomain, code: NSFileNoSuchFileError, userInfo: nil))")
        }
        path = root.appendingPathComponent(name, isDirectory: true)
    }

    public func fileURL(with name: String) -> URL {
        path.appendingPathComponent(name)
    }

    public func removeFile(for name: String) {
        let url = fileURL(with: name)
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        try? FileManager.default.removeItem(at: url)
    }
}

public extension AudioFileService {
    enum Resource: String, CaseIterable {
        case click = "click"

        var type: String {
            switch self {
            case .click:
                return "mp3"
            }
        }
    }

    static func resource(for name: String, of type: String) -> URL? {
        guard let path = Bundle.module.path(forResource: name, ofType: type) else { return nil }
        return URL(fileURLWithPath: path)
    }

    static func resource(for resource: Resource) -> URL? {
        return Self.resource(for: resource.rawValue, of: resource.type)
    }
}
