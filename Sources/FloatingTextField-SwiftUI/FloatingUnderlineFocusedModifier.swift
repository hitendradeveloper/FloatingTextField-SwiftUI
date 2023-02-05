//
//  FloatingUnderlineFocusedModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI
import UIKit
import Introspect


extension Modifiers.FloatingFocusedUnderline {
	public  class Configuration {
		public var floatingUnderlineConfiguration: Modifiers.FloatingUnderline.Configuration
		var focusedColor: Color
		var textField: Binding<UITextField?>
		
		var isFirstResponder: Bool = false

		init(floatingUnderlineConfiguration: Modifiers.FloatingUnderline.Configuration, textField: Binding<UITextField?>) {
			
			self.floatingUnderlineConfiguration = floatingUnderlineConfiguration
			
			self.textField = textField
			self.focusedColor = Color.accentColor
			
			if let textField = textField.wrappedValue {
				if textField.text == floatingUnderlineConfiguration.floatingConfiguration.text.wrappedValue &&
					textField.placeholder == floatingUnderlineConfiguration.floatingConfiguration.placeHolder {
					
					self.floatingUnderlineConfiguration.underlineColor(focusedColor)
				}
			}
			
		}
		
		public convenience init(placeHolder: String, text: Binding<String>, textField: Binding<UITextField?>) {
			
			let floatingConfiguation: Modifiers.Floating.Configuration = .init(placeHolder: placeHolder, text: text)
			let floatingUnderlineConfiguration: Modifiers.FloatingUnderline.Configuration = .init(floatingConfiguration: floatingConfiguation)
			
			self.init(floatingUnderlineConfiguration: floatingUnderlineConfiguration, textField: textField)
			
		}
		
		@discardableResult
		public func focusedColor(_ focusedColor: Color) -> Self { self.focusedColor = focusedColor; return self }
	}
}



public extension View {
	
	@ViewBuilder
	func floatingUnderlineFocused(_ configuration: Modifiers.FloatingFocusedUnderline.Configuration) -> some View {
		self
			.syncWithFocused(syncer: configuration.textField)
			.modifier(Modifiers.FloatingFocusedUnderline(configuration: configuration))
	}
	
	@ViewBuilder
	func syncWithFocused(syncer: Binding<UITextField?>) -> some View {
		self
			.introspectTextField { introspectedTextField in
				if introspectedTextField.isFirstResponder && introspectedTextField != syncer.wrappedValue {
					syncer.wrappedValue = introspectedTextField
				}
			}
	}
}


extension Modifiers {
	public struct FloatingFocusedUnderline: ViewModifier {
		
		var configuration: Configuration
		
		weak private var textField: UITextField?
		var isFirstResponder: Bool = false
		
		
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View {
			let _ = print("configuration.isFirstResponder := \(configuration.isFirstResponder)")
			content
				.floatingUnderline(configuration.floatingUnderlineConfiguration)
		}
	}
}
