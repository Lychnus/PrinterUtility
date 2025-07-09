//
//  DevTools.swift
//  PrinterUtility
//
//  Created by Tahir Anil Oghan on 8.07.2025.
//

import Foundation

public enum DevTools {
    public static let print: ConsolePrinter = AppPrinter.shared
    
    internal static var isTesting: Bool {
        NSClassFromString("XCTest") != nil
    }
}
