//
//  AppPrinter.swift
//  PrinterUtility
//
//  Created by Tahir Anil Oghan on 7.07.2025.
//

import Foundation

// MARK: - Protocol
/// A protocol that defines a development-only console printer.
public protocol ConsolePrinter {
    
    /// This function will write the `success` print event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - text: Message to print.
    ///   - includeContext: Whether to include file/function/line info in the print output.
    ///   - file: Auto-injected file name (use default).
    ///   - line: Auto-injected line number (use default).
    ///   - function: Auto-injected function name (use default).
    func success(
        _ text: String,
        includeContext: Bool,
        file: String,
        line: Int,
        function: String
    )
    
    /// This function will write the `info` print event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - text: Message to print.
    ///   - includeContext: Whether to include file/function/line info in the print output.
    ///   - file: Auto-injected file name (use default).
    ///   - line: Auto-injected line number (use default).
    ///   - function: Auto-injected function name (use default).
    func info(
        _ text: String,
        includeContext: Bool,
        file: String,
        line: Int,
        function: String
    )
    
    /// This function will write the `warning` print event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - text: Message to print.
    ///   - includeContext: Whether to include file/function/line info in the print output.
    ///   - file: Auto-injected file name (use default).
    ///   - line: Auto-injected line number (use default).
    ///   - function: Auto-injected function name (use default).
    func warning(
        _ text: String,
        includeContext: Bool,
        file: String,
        line: Int,
        function: String
    )
    
    /// This function will write the `error` print event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - text: Message to print.
    ///   - includeContext: Whether to include file/function/line info in the print output.
    ///   - file: Auto-injected file name (use default).
    ///   - line: Auto-injected line number (use default).
    ///   - function: Auto-injected function name (use default).
    func error(
        _ text: String,
        includeContext: Bool,
        file: String,
        line: Int,
        function: String
    )
}

// MARK: - Console Printer Wrapper For Default Parameters
/// This struct provides a wrapper for `ConsolePrinter` that exposes its internals with default parameters.
public struct ConsolePrinterWrapper {
    private let printer: ConsolePrinter

    public init(printer: ConsolePrinter) {
        self.printer = printer
    }

    public func success(_ text: String, includeContext: Bool = false, file: String = #file, line: Int = #line, function: String = #function) {
        printer.success(text, includeContext: includeContext, file: file, line: line, function: function)
    }

    public func info(_ text: String, includeContext: Bool = false, file: String = #file, line: Int = #line, function: String = #function) {
        printer.info(text, includeContext: includeContext, file: file, line: line, function: function)
    }

    public func warning(_ text: String, includeContext: Bool = false, file: String = #file, line: Int = #line, function: String = #function) {
        printer.warning(text, includeContext: includeContext, file: file, line: line, function: function)
    }

    public func error(_ text: String, includeContext: Bool = false, file: String = #file, line: Int = #line, function: String = #function) {
        printer.error(text, includeContext: includeContext, file: file, line: line, function: function)
    }
}

// MARK: - Implementation
/// This struct is responsible for printing actions during development.
/// It provides formatted, context-aware print messages with severity levels.
internal class AppPrinter: ConsolePrinter {
    
    /// Singleton instance.
    internal static let shared = AppPrinter()
    
    /// Last known printed output. (For testing purposes.)
    internal private(set) var testOutput: String = ""
    
    /// This enum has options to represent the severity of the printed text.
    private enum PrintSeverity: String {
        case success = "[🟢 - Success]"
        case info = "[⚪️ - Info]"
        case warning = "[🟡 - Warning]"
        case error = "[🔴 - Error]"
    }
    
    /// This struct is responsible for providing specific context information about the printed text.
    private struct PrintContext {
        
        /// File name
        private let file: String
        
        /// Function name
        private let function: String
        
        /// Line number
        private let line: Int
        
        init(file: String, function: String, line: Int) {
            self.file = file
            self.function = function
            self.line = line
        }
        
        /// Readable, formatted context information.
        var information: String {
            return "Context: [Path: \((file as NSString).lastPathComponent), Line: \(line), Function: \(function)]"
        }
    }
    
    /// Secured initializer to enforce `.shared` usage.
    private init() { }
    
    /// This function internally handles the formatted print event.
    ///
    /// - Parameters:
    ///   - severity: The severity level of the print output.
    ///   - description: The main message to print.
    ///   - includeContext: Whether to include file/function/line info in the print output.
    ///   - context: The resolved context information for the print event.
    private func handle(
        severity: PrintSeverity,
        description: String,
        includeContext: Bool,
        context: PrintContext
    ) {
        var components = [severity.rawValue, description]
        if includeContext { components.append(context.information) }
        
        let textToPrint = components.joined(separator: " ")
        
        // Eliminate the print behavior in test environment.
        if DevTools.isTesting {
            testOutput = textToPrint
            return
        }
        
        // Restrict the print behavior to development environment only.
        #if DEBUG
        print(textToPrint)
        #endif
    }
    
}

// MARK: - Protocol Conformance
extension AppPrinter {
    
    internal func success(_ text: String, includeContext: Bool = false, file: String = #file, line: Int = #line, function: String = #function) {
        let context = PrintContext(file: file, function: function, line: line)
        handle(severity: .success, description: text, includeContext: includeContext, context: context)
    }
    
    internal func info(_ text: String, includeContext: Bool = false, file: String = #file, line: Int = #line, function: String = #function) {
        let context = PrintContext(file: file, function: function, line: line)
        handle(severity: .info, description: text, includeContext: includeContext, context: context)
    }
    
    internal func warning(_ text: String, includeContext: Bool = false, file: String = #file, line: Int = #line, function: String = #function) {
        let context = PrintContext(file: file, function: function, line: line)
        handle(severity: .warning, description: text, includeContext: includeContext, context: context)
    }
    
    internal func error(_ text: String, includeContext: Bool = false, file: String = #file, line: Int = #line, function: String = #function) {
        let context = PrintContext(file: file, function: function, line: line)
        handle(severity: .error, description: text, includeContext: includeContext, context: context)
    }
}

// MARK: - Factory Initializer
#if DEBUG
extension AppPrinter {
    
    /// Returns a new, isolated instance of `AppPrinter` for testing purposes.
    ///
    /// - Returns: A fresh `AppPrinter` instance, separate from the shared singleton.
    ///
    /// Use this method in tests to avoid side effects and ensure output isolation.
    internal static func mock() -> AppPrinter {
        AppPrinter()
    }
}
#endif
