//
//  UnderlineModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI

extension Modifiers.Underline {
	public  class Configuration {
		var underlineColor: Color
		var underlineHeight: CGFloat
		var underlinePadding: CGFloat

		
		public init() {
			self.underlineColor = FloatingTextFieldConfiguration.shared.underlineColor
			self.underlineHeight = FloatingTextFieldConfiguration.shared.underlineHeight
			self.underlinePadding = FloatingTextFieldConfiguration.shared.underlinePadding
		}
		
		@discardableResult
		public func underlineColor(_ underlineColor: Color) -> Self { self.underlineColor = underlineColor; return self }
		
		@discardableResult
		public func underlineHeight(_ underlineHeight: CGFloat) -> Self { self.underlineHeight = underlineHeight; return self }
		
		@discardableResult
		public func underlinePadding(_ underlinePadding: CGFloat) -> Self { self.underlinePadding = underlinePadding; return self }
		
	}
}

public extension View {
	
	@ViewBuilder
	func floatingUnderline(_ configuration: Modifiers.Underline.Configuration) -> some View {
		self
			.modifier(Modifiers.Underline(configuration: configuration))
	}
	
	@ViewBuilder
	fileprivate func drawUnderLine(color: Color, height: CGFloat) -> some View{
		ZStack(alignment: .bottom) {
			self
			Rectangle()
				.frame(height: height)
				.foregroundColor(color)
		}
	}
}


extension Modifiers {
	public struct Underline: ViewModifier {
		
		var configuration: Configuration
		
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View {
			content
				.padding(.bottom, configuration.underlinePadding)
				.drawUnderLine(
					color: configuration.underlineColor,
					height: configuration.underlineHeight
				)
		}
	}
}

extension Modifiers.Underline.Configuration: OnFocusChangeConfigurable {
	public func configure(focusedConfiguration: Modifiers.Focused.Configuration) -> Self {
		if focusedConfiguration.isFocused {
			self.underlineColor = focusedConfiguration.focusedColor
		}
		return self
	}
}
