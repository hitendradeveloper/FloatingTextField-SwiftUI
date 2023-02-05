//
//  FloatingUnderlineModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI
import UIKit

extension Modifiers.FloatingUnderline {
	public  class Configuration {
		public var floatingConfiguration: Modifiers.Floating.Configuration
		
		var underlineColor: Color
		var underlineHeight: CGFloat
		
		init(floatingConfiguration: Modifiers.Floating.Configuration) {
			self.underlineColor = floatingConfiguration.placeholderColor
			self.underlineHeight = 1.0
			self.floatingConfiguration = floatingConfiguration
		}
		
		public convenience init(placeHolder: String, text: Binding<String>) {
			let floatingConfiguation: Modifiers.Floating.Configuration = .init(placeHolder: placeHolder, text: text)
			self.init(floatingConfiguration: floatingConfiguation)
		}
		
		@discardableResult
		public func underlineColor(_ underlineColor: Color) -> Self { self.underlineColor = underlineColor; return self }
		
		@discardableResult
		public func underlineHeight(_ underlineHeight: CGFloat) -> Self { self.underlineHeight = underlineHeight; return self }
		
		@discardableResult
		public func floatingConfiguration(_ configuration: Modifiers.Floating.Configuration) -> Self { self.floatingConfiguration = configuration; return self }
	}
}

public extension View {
	
	@ViewBuilder
	func floatingUnderline(_ configuration: Modifiers.FloatingUnderline.Configuration) -> some View {
		self
			.modifier(Modifiers.FloatingUnderline(configuration: configuration))
	}
}


extension Modifiers {
	public struct FloatingUnderline: ViewModifier {
		
		var configuration: Configuration
		
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View {
			content
				.floating(configuration.floatingConfiguration)
				.drawUnderLine(
					color: configuration.underlineColor,
					height: configuration.underlineHeight
				)
		}
	}
}

