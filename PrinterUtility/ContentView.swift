//
//  ContentView.swift
//  PrinterUtility
//
//  Created by Tahir Anil Oghan on 7.07.2025.
//

import SwiftUI

// MARK: - Implementation
struct ContentView {
    
    /// Decide if context should be added on `DevTools.print..`
    @State private var shouldPrintWithContext: Bool = false
}

// MARK: - View
extension ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section("Settings") {
                    Toggle("Include Context Info", isOn: $shouldPrintWithContext)
                }
                
                Section("Log Events") {
                    logButton("Success Log", severity: .success, message: "Operation completed successfully.")
                    logButton("Info Log", severity: .info, message: "Something informative happened.")
                    logButton("Warning Log", severity: .warning, message: "This might be a problem.")
                    logButton("Error Log", severity: .error, message: "Something went wrong.")
                }
            }
            .navigationTitle("PrinterUtility Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Private Functions
extension ContentView {
    
    private enum Severity {
        case success, info, warning, error
    }
    
    @ViewBuilder
    private func logButton(_ title: String, severity: Severity, message: String) -> some View {
        Button(title) {
            switch severity {
            case .success:
                DevTools.print.success(message, includeContext: shouldPrintWithContext)
            case .info:
                DevTools.print.info(message, includeContext: shouldPrintWithContext)
            case .warning:
                DevTools.print.warning(message, includeContext: shouldPrintWithContext)
            case .error:
                DevTools.print.error(message, includeContext: shouldPrintWithContext)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
