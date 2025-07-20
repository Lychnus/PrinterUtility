//
//  CustomPrinterTests.swift
//  PrinterUtility
//
//  Created by Tahir Anil Oghan on 7.07.2025.
//

import Foundation
import Testing
@testable import PrinterUtility

@Suite("CustomPrinter Tests")
struct CustomPrinterTests {
    
    // MARK: - ConsolePrinterSeverity Tests
    
    @Test("Success-Severity description created correctly.")
    func testSuccessSeverityDescriptionCreation() {
        let description = ConsolePrinterSeverity.success.description
        
        #expect(description == "[🟢 - Success]")
    }
    
    @Test("Info-Severity description created correctly.")
    func testInfoSeverityDescriptionCreation() {
        let description = ConsolePrinterSeverity.info.description
        
        #expect(description == "[⚪️ - Info]")
    }
    
    @Test("Warning-Severity description created correctly")
    func testWarningSeverityDescriptionCreation() {
        let description = ConsolePrinterSeverity.warning.description
        
        #expect(description == "[🟡 - Warning]")
    }
    
    @Test("Error-Severity description created correctly.")
    func testErrorSeverityDescriptionCreation() {
        let description = ConsolePrinterSeverity.error.description
        
        #expect(description == "[🔴 - Error]")
    }
    
    @Test("Custom-Severity description created correctly.")
    func testCustomSeverityDescriptionCreation() {
        let description = ConsolePrinterSeverity.custom("[🟣 - Notice]").description
        
        #expect(description == "[🟣 - Notice]")
    }
    
    // MARK: - CustomPrinterContext Tests
    
    @Test("Context information created correctly.")
    func testContextInformationCreation() {
        let context = CustomPrinterContext(file: #fileID, function: #function, line: #line)
        let information = context.information
        
        #expect(information.contains("File: PrinterUtilityTests/CustomPrinterTests.swift"))
        #expect(information.contains("Function: testContextInformationCreation()"))
        #expect(information.contains("Line:"))
    }
    
    // MARK: - AppPrinter Tests
    
    @Test("Print output creation without context is succeeds.")
    func testPrintOutputCreationWithoutContext() {
        let mock = CustomPrinter.mock()
        let output = mock.createOutput(severity: .success,
                                       message: "Success event.",
                                       includeContext: false,
                                       context: CustomPrinterContext(file: #fileID, function: #function, line: #line))
        
        #expect(output == "[🟢 - Success] Success event.")
        #expect(output.contains("Context:") == false)
    }
    
    @Test("Print output creation with context is succeeds.")
    func testPrintOutputCreationWithContext() {
        let mock = CustomPrinter.mock()
        let context = CustomPrinterContext(file: #fileID, function: #function, line: #line)
        let output = mock.createOutput(severity: .success,
                                       message: "Success event.",
                                       includeContext: true,
                                       context: context)
        
        #expect(output.contains("[🟢 - Success] Success event."))
        #expect(output.contains("File: PrinterUtilityTests/CustomPrinterTests.swift"))
        #expect(output.contains("Function: testPrintOutputCreationWithContext()"))
        #expect(output.contains("Line:"))
    }
    
    @Test("Protocol conformance of ConsolePrint works correctly.")
    func testProtocolConformanceDebugPrint() {
        let mock = CustomPrinter.mock()
        mock.consolePrint(.success, "Success event.", includeContext: true, file: #fileID, line: #line, function: #function)
        let output = mock.printedOutput
        
        #expect(output.contains("[🟢 - Success] Success event."))
        #expect(output.contains("File: PrinterUtilityTests/CustomPrinterTests.swift"))
        #expect(output.contains("Function: testProtocolConformanceDebugPrint()"))
        #expect(output.contains("Line:"))
    }
    
    // MARK: - ConsolePrinter Protocol Overload Tests
    
    @Test("ConsolePrint overload without context works correctly.")
    func testDebugPrintOverloadWithoutContext() {
        let mock = CustomPrinter.mock()
        mock.consolePrint(.custom("[🟣 - Notice]"), "Notice event.")
        let output = mock.printedOutput
        
        #expect(output == "[🟣 - Notice] Notice event.")
        #expect(output.contains("Context:") == false)
    }
    
    @Test("ConsolePrint overload with context works correctly.")
    func testDebugPrintOverloadWithContext() {
        let mock = CustomPrinter.mock()
        mock.consolePrint(.custom("[🟣 - Notice]"), "Notice event.", contextIncluded: true)
        let output = mock.printedOutput
        
        #expect(output.contains("[🟣 - Notice] Notice event."))
        #expect(output.contains("Context:") == true)
    }
    
    @Test("SuccessPrint overload without context works correctly.")
    func testSuccessPrintOverloadWithoutContext() {
        let mock = CustomPrinter.mock()
        mock.success("Success event.")
        let output = mock.printedOutput
        
        #expect(output == "[🟢 - Success] Success event.")
        #expect(output.contains("Context:") == false)
    }
    
    @Test("SuccessPrint overload with context works correctly.")
    func testSuccessPrintOverloadWithContext() {
        let mock = CustomPrinter.mock()
        mock.success("Success event.", contextIncluded: true)
        let output = mock.printedOutput
        
        #expect(output.contains("[🟢 - Success] Success event."))
        #expect(output.contains("Context:") == true)
    }
    
    @Test("InfoPrint overload without context works correctly.")
    func testInfoPrintOverloadWithoutContext() {
        let mock = CustomPrinter.mock()
        mock.info("Info event.")
        let output = mock.printedOutput
        
        #expect(output == "[⚪️ - Info] Info event.")
        #expect(output.contains("Context:") == false)
    }
    
    @Test("InfoPrint overload with context works correctly.")
    func testInfoPrintOverloadWithContext() {
        let mock = CustomPrinter.mock()
        mock.info("Info event.", contextIncluded: true)
        let output = mock.printedOutput
        
        #expect(output.contains("[⚪️ - Info] Info event."))
        #expect(output.contains("Context:") == true)
    }
    
    @Test("WarningPrint overload without context works correctly.")
    func testWarningPrintOverloadWithoutContext() {
        let mock = CustomPrinter.mock()
        mock.warning("Warning event.")
        let output = mock.printedOutput
        
        #expect(output == "[🟡 - Warning] Warning event.")
        #expect(output.contains("Context:") == false)
    }
    
    @Test("WarningPrint overload with context works correctly.")
    func testWarningPrintOverloadWithContext() {
        let mock = CustomPrinter.mock()
        mock.warning("Warning event.", contextIncluded: true)
        let output = mock.printedOutput
        
        #expect(output.contains("[🟡 - Warning] Warning event."))
        #expect(output.contains("Context:") == true)
    }
    
    @Test("ErrorPrint overload without context works correctly.")
    func testErrorPrintOverloadWithoutContext() {
        let mock = CustomPrinter.mock()
        mock.error("Error event.")
        let output = mock.printedOutput
        
        #expect(output == "[🔴 - Error] Error event.")
        #expect(output.contains("Context:") == false)
    }
    
    @Test("ErrorPrint overload with context works correctly.")
    func testErrorPrintOverloadWithContext() {
        let mock = CustomPrinter.mock()
        mock.error("Error event.", contextIncluded: true)
        let output = mock.printedOutput
        
        #expect(output.contains("[🔴 - Error] Error event."))
        #expect(output.contains("Context:") == true)
    }
}
