//
//  AppPrinterTests.swift
//  PrinterUtility
//
//  Created by Tahir Anil Oghan on 7.07.2025.
//

import Foundation
import Testing
@testable import PrinterUtility

@Suite("AppPrinter Tests")
struct AppPrinterTests {
    
    @Test("Success message formatting without context")
    func testSuccessMessageWithoutContext() {
        let printer = AppPrinter.mock()
        printer.success("Operation completed successfully")
        
        #expect(printer.testOutput == "[🟢 - Success] Operation completed successfully")
    }
    
    @Test("Success message formatting with context")
    func testSuccessMessageWithContext() {
        let printer = AppPrinter.mock()
        printer.success("Operation completed successfully", includeContext: true)
        
        let output = printer.testOutput
        #expect(output.hasPrefix("[🟢 - Success] Operation completed successfully"))
        #expect(output.contains("Context:"))
        #expect(output.contains("Line:"))
        #expect(output.contains("Function: testSuccessMessageWithContext()"))
    }
    
    @Test("Info message formatting without context")
    func testInfoMessageWithoutContext() {
        let printer = AppPrinter.mock()
        printer.info("Processing user data")
        
        #expect(printer.testOutput == "[⚪️ - Info] Processing user data")
    }
    
    @Test("Info message formatting with context")
    func testInfoMessageWithContext() {
        let printer = AppPrinter.mock()
        printer.info("Processing user data", includeContext: true)
        
        let output = printer.testOutput
        #expect(output.hasPrefix("[⚪️ - Info] Processing user data"))
        #expect(output.contains("Context:"))
        #expect(output.contains("Line:"))
        #expect(output.contains("Function: testInfoMessageWithContext()"))
    }
    
    @Test("Warning message formatting without context")
    func testWarningMessageWithoutContext() {
        let printer = AppPrinter.mock()
        printer.warning("Deprecated API usage detected")
        
        #expect(printer.testOutput == "[🟡 - Warning] Deprecated API usage detected")
    }
    
    @Test("Warning message formatting with context")
    func testWarningMessageWithContext() {
        let printer = AppPrinter.mock()
        printer.warning("Deprecated API usage detected", includeContext: true)
        
        let output = printer.testOutput
        #expect(output.hasPrefix("[🟡 - Warning] Deprecated API usage detected"))
        #expect(output.contains("Context:"))
        #expect(output.contains("Line:"))
        #expect(output.contains("Function: testWarningMessageWithContext()"))
    }
    
    @Test("Error message formatting without context")
    func testErrorMessageWithoutContext() {
        let printer = AppPrinter.mock()
        printer.error("Network request failed")
        
        #expect(printer.testOutput == "[🔴 - Error] Network request failed")
    }
    
    @Test("Error message formatting with context")
    func testErrorMessageWithContext() {
        let printer = AppPrinter.mock()
        printer.error("Network request failed", includeContext: true)
        
        let output = printer.testOutput
        #expect(output.hasPrefix("[🔴 - Error] Network request failed"))
        #expect(output.contains("Context:"))
        #expect(output.contains("Line:"))
        #expect(output.contains("Function: testErrorMessageWithContext()"))
    }
    
    @Test("Multiple consecutive calls update testOutput")
    func testMultipleConsecutiveCalls() {
        let printer = AppPrinter.mock()
        
        printer.success("First message")
        #expect(printer.testOutput == "[🟢 - Success] First message")
        
        printer.error("Second message")
        #expect(printer.testOutput == "[🔴 - Error] Second message")
        
        printer.info("Third message", includeContext: true)
        let output = printer.testOutput
        #expect(output.hasPrefix("[⚪️ - Info] Third message"))
        #expect(output.contains("Context:"))
        #expect(output.contains("Line:"))
        #expect(output.contains("Function: testMultipleConsecutiveCalls()"))
    }
}
