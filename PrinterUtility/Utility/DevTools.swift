//
//  DevTools.swift
//  PrinterUtility
//
//  Created by Tahir Anil Oghan on 8.07.2025.
//

import Foundation

public enum DevTools {
    public static let print: ConsolePrinterWrapper = ConsolePrinterWrapper(printer: AppPrinter.shared)
    
    internal static var isTesting: Bool {
        NSClassFromString("XCTest") != nil
    }
}
