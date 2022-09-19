//
//  AudioFileService.swift
//  
//
//  Created by Shunya Yamada on 2022/09/19.
//

import Foundation

public enum AudioFileService {
    public enum Resource: String {
        case click = "click"

        var type: String {
            switch self {
            case .click:
                return "mp3"
            }
        }
    }

    static public func resource(for name: String, of type: String) -> URL? {
        guard let path = Bundle.module.path(forResource: name, ofType: type) else { return nil }
        return URL(fileURLWithPath: path)
    }

    static public func resource(for resource: Resource) -> URL? {
        return Self.resource(for: resource.rawValue, of: resource.type)
    }
}
