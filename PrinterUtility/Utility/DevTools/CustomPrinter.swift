//
//  CustomPrinter.swift
//  PrinterUtility
//
//  Created by Tahir Anil Oghan on 7.07.2025.
//

import Foundation

// MARK: - Protocol
/// A protocol that defines a development-only console printer.
public protocol ConsolePrinter {
    
    /// This function will write the pretty `print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - severity: Severity level of the print event.
    ///   - text: Message to print.
    ///   - includeContext: Whether to include file / function / line info in the print output.
    ///   - file: Auto-injected file name (use default).
    ///   - line: Auto-injected line number (use default).
    ///   - function: Auto-injected function name (use default).
    func consolePrint(
        _ severity: ConsolePrinterSeverity,
        _ message: String,
        includeContext: Bool,
        file: String,
        line: Int,
        function: String
    )
}

// MARK: - Protocol Extension (Convenience Overloads)
extension ConsolePrinter {
    
    /// This function will write the pretty `print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - severity: Severity level of the print event.
    ///   - message: Message to print.
    public func consolePrint(_ severity: ConsolePrinterSeverity, _ message: String) {
        consolePrint(severity, message, includeContext: false, file: #fileID, line: #line, function: #function)
    }
    
    /// This function will write the pretty `print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - severity: Severity level of the print event.
    ///   - message: Message to print.
    ///   - contextIncluded: Whether to include file / function / line info in the print output.
    public func consolePrint(
        _ severity: ConsolePrinterSeverity,
        _ message: String,
        contextIncluded: Bool,
        file: String = #fileID,
        line: Int = #line,
        function: String = #function
    ) {
        consolePrint(severity, message, includeContext: contextIncluded, file: file, line: line, function: function)
    }
    
    /// This function will write the pretty `success print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - message: Message to print.
    public func success(_ message: String) {
        consolePrint(.success, message, includeContext: false, file: #fileID, line: #line, function: #function)
    }
    
    /// This function will write the pretty `success print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - message: Message to print.
    ///   - contextIncluded: Whether to include file / function / line info in the print output.
    public func success(
        _ message: String,
        contextIncluded: Bool,
        file: String = #fileID,
        line: Int = #line,
        function: String = #function
    ) {
        consolePrint(.success, message, includeContext: contextIncluded, file: file, line: line, function: function)
    }
    
    /// This function will write the pretty `info print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - message: Message to print.
    public func info(_ message: String) {
        consolePrint(.info, message, includeContext: false, file: #fileID, line: #line, function: #function)
    }
    
    /// This function will write the pretty `info print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - message: Message to print.
    ///   - contextIncluded: Whether to include file / function / line info in the print output.
    public func info(
        _ message: String,
        contextIncluded: Bool,
        file: String = #fileID,
        line: Int = #line,
        function: String = #function
    ) {
        consolePrint(.info, message, includeContext: contextIncluded, file: file, line: line, function: function)
    }
    
    /// This function will write the pretty `warning print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - message: Message to print.
    public func warning(_ message: String) {
        consolePrint(.warning, message, includeContext: false, file: #fileID, line: #line, function: #function)
    }
    
    /// This function will write the pretty `warning print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - message: Message to print.
    ///   - contextIncluded: Whether to include file / function / line info in the print output.
    public func warning(
        _ message: String,
        contextIncluded: Bool,
        file: String = #fileID,
        line: Int = #line,
        function: String = #function
    ) {
        consolePrint(.warning, message, includeContext: contextIncluded, file: file, line: line, function: function)
    }
    
    /// This function will write the pretty `error print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - message: Message to print.
    public func error(_ message: String) {
        consolePrint(.error, message, includeContext: false, file: #fileID, line: #line, function: #function)
    }
    
    /// This function will write the pretty `error print` event to the console which is only visible in the development environment.
    ///
    /// - Parameters:
    ///   - message: Message to print.
    ///   - contextIncluded: Whether to include file / function / line info in the print output.
    public func error(
        _ message: String,
        contextIncluded: Bool,
        file: String = #fileID,
        line: Int = #line,
        function: String = #function
    ) {
        consolePrint(.error, message, includeContext: contextIncluded, file: file, line: line, function: function)
    }
}

// MARK: - Helpers
/// This enum has options to represent the severity of the print event.
public enum ConsolePrinterSeverity {
    
    /// This option will add `[🟢 - Success]` to prefix of the print output.
    case success
    
    /// This option will add `[⚪️ - Info]` to prefix of the print output.
    case info
    
    /// This option will add `[🟡 - Warning]` to prefix of the print output.
    case warning
    
    /// This option will add `[🔴 - Error]` to prefix of the print output.
    case error
    
    /// Custom severity e.g. `"[🟣 - Notice]"`
    case custom(String)
    
    /// String representation of the severity option.
    internal var description: String {
        switch self {
            case .success: return "[🟢 - Success]"
            case .info: return "[⚪️ - Info]"
            case .warning: return "[🟡 - Warning]"
            case .error: return "[🔴 - Error]"
            case .custom(let customSeverity): return customSeverity
        }
    }
}

/// This struct is responsible for providing specific context information about the print event.
internal struct CustomPrinterContext {
    
    /// File name.
    private let file: String
    
    /// Function name.
    private let function: String
    
    /// Line number.
    private let line: Int
    
    /// Context initializer.
    ///  - Parameters:
    ///   - file: File name.
    ///   - line: Line number.
    ///   - function: Function name.
    internal init(file: String, function: String, line: Int) {
        self.file = file
        self.function = function
        self.line = line
    }
    
    /// Readable, formatted context information.
    internal var information: String {
        return "Context: [File: \(file), Function: \(function), Line: \(line)]"
    }
}

// MARK: - Implementation
/// This class is responsible for printing actions during development.
/// It provides formatted, context-aware print messages with severity levels.
internal final class CustomPrinter {
    
    /// Singleton instance.
    internal static let shared: CustomPrinter = CustomPrinter()
    
    /// Mocked printed property for testing purpose.
    internal var printedOutput: String = ""
    
    /// Secured initializer to enforce `.shared` usage.
    private init() { }
}

// MARK: - Internal Methods
extension CustomPrinter {
    
    /// This function handles the creation of print output.
    ///
    /// - Parameters:
    ///   - severity: Severity level of the print output.
    ///   - message: Message to print.
    ///   - includeContext: Whether to include file / function / line info in the print output.
    ///   - context: Resolved context information for the print event.
    ///  - Returns: Printable String output.
    internal func createOutput(
        severity: ConsolePrinterSeverity,
        message: String,
        includeContext: Bool,
        context: CustomPrinterContext
    ) -> String {
        var components = [severity.description, message]
        if includeContext { components.append(context.information) }
        return components.joined(separator: " ")
    }
}

// MARK: - Private Methods
extension CustomPrinter {
    
    /// This function returns `true` if test environment is running.
    private func onTesting() -> Bool {
        NSClassFromString("XCTest") != nil
    }
}

// MARK: - Protocol Conformance
extension CustomPrinter: ConsolePrinter {
    
    internal func consolePrint(
        _ severity: ConsolePrinterSeverity,
        _ message: String,
        includeContext: Bool,
        file: String,
        line: Int,
        function: String
    ) {
        let context = CustomPrinterContext(file: file, function: function, line: line)
        let output = createOutput(severity: severity, message: message, includeContext: includeContext, context: context)
        
        // Eliminate print behavior on test environment.
        if onTesting() {
            printedOutput = output
            return
        }

        // Restrict the print behavior to development environment only.
        #if DEBUG
        print(output)
        #endif
    }
}

// MARK: - Factory Initializer
#if DEBUG
extension CustomPrinter {
    
    /// Returns a new, isolated instance of `CustomPrinter` for testing purposes.
    ///
    /// - Returns: A fresh `CustomPrinter` instance, separate from the shared singleton.
    ///
    /// Use this method in tests to access mocked print output.
    internal static func mock() -> CustomPrinter {
        CustomPrinter()
    }
}
#endif
