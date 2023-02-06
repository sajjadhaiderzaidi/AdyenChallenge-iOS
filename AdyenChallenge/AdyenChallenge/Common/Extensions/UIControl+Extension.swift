//
//  UIControl+Extension.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import UIKit

extension UIControl {
    
    /// Adds Command to UIControl
    /// - Parameters:
    ///   - controlEvents: UIControl.Event
    ///   - command: Command
    func addAction(for controlEvents: UIControl.Event = .touchUpInside,
                   command: Command) {
        addAction(UIAction { (action: UIAction) in
            command.execute()
        }, for: controlEvents)
    }
    
}
