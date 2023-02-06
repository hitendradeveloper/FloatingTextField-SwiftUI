//
//  UITextField+Identifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import UIKit

public extension UITextField {
	struct TextFieldKeys {
		static var identifier : String = "UITextField.TextFieldKeys.identifier"
	}
	
	typealias Identifier = String
	var identifier: Identifier?  {
		get {
			let value = objc_getAssociatedObject(self, &TextFieldKeys.identifier) as? Identifier
			return value
		}
		set { captureCopy(newValue: newValue) }
	}
	
	private func captureCopy(newValue: Identifier?) {
		guard let newValue = newValue else { return }
		objc_setAssociatedObject(self, &TextFieldKeys.identifier, newValue, .OBJC_ASSOCIATION_COPY)
	}
}

