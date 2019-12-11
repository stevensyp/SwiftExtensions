//
//  SEDebug.swift
//
//  Created by Steven Syp on 6/11/19.
//  Copyright © 2019 Steven Syp. All rights reserved.
//

import Foundation

/// Holds custom debug functions with log messages and types.
final class SEDebug {

    /// Displays a composed log in the standard output.
    /// - Parameters:
    ///   - type: Type of the log — see `LogType` all types
    ///   - msg: Content displayed at the top of the log, next to its type
    ///   - detail: Content displayed in second place, as detail
    ///   - file: File emitting the log
    static func log(_ type: LogType, _ msg: Any, detail: Any? = nil, file: String = #file) {
        let filename: String = file.components(separatedBy: "/").last!
            .replacingOccurrences(of: "ViewController", with: "")

        print("\n\(type.rawValue) · \(filename) →\(type.logKey) \(msg)")
        if let detail = detail { print("⚙️ → \(detail)\n") }
    }

    // MARK: Fatal Debug Log (terminating version)
    /// Displays a composed log in the standard output and terminates the process.
    /// - Parameters:
    ///   - msg: Content displayed at the top of the log, next to its type
    ///   - detail: Content displayed in second place, as detail
    ///   - file: File emitting the log
    static func fatalLog(_ msg: Any, detail: Any? = nil, file: String = #file) -> Never {
        log(.fatalError, msg, detail: detail, file: file)
        fatalError("App execution terminated.")
    }

    // MARK: - Log Types
    /// Type of the log, represented by the corresponding emoji
    enum LogType: String {
        case comment = "💎", warning = "⚡️"
        case success = "🍀", error = "🔥"
        case fatalError = "💀"

        /// Log type's related verbose key.
        var logKey: String {
            switch self {
            case .comment:      return ""
            case .warning:      return " WARNING:"
            case .success:      return " SUCCESS:"
            case .error:        return " ERROR:"
            case .fatalError:   return " FATAL ERROR:"
            }
        }
    }

}




