//
//  Command.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import Foundation

typealias Command = CommandOf<Void>

/// Application of behavioral design pattern to converts actions/operations into objects.
public class CommandOf<T> {
    
    /// underlying closure / block
    let action: (T) -> ()
    
    private let id: String
    private let file: StaticString
    private let function: StaticString
    private let line: Int
    
    public init(id: String = "unnamed",
                file: StaticString = #file,
                function: StaticString = #function,
                line: Int = #line,
                action: @escaping (T) -> ()) {
        self.id = id
        self.file = file
        self.function = function
        self.line = line
        self.action = action
    }
    
    func execute(with value: T) {
        action(value)
    }
}

extension CommandOf {
    
    /// No operation command
    static var nop: CommandOf { CommandOf(id: "nop") { _ in } }
    
}

extension CommandOf where T == Void {
    
    func execute() {
        execute(with: ())
    }
    
}


/// Allows Command to be compared and stored in sets and dicts.
/// Uses ObjectIdentifier to distinguish between Commands
extension CommandOf: Hashable, Equatable {
    public static
        func == (left: CommandOf, right: CommandOf) -> Bool {
        ObjectIdentifier(left) == ObjectIdentifier(right)
    }
    
    public
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    
    #if !swift(>=5)
    public
    var hashValue: Int { ObjectIdentifier(self).hashValue }
    #endif
}
